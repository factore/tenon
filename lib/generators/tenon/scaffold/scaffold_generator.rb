module Tenon
  module Generators
    class ScaffoldGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      argument :attributes, type: :array, default: [], banner: 'field:type field:type'
      class_option :small, type: :boolean, default: false, description: 'Use the small-style template?'
      invoke :model

      def copy_files
        # Controller, helper, views, test and stylesheets directories.
        empty_directory(File.join('app/views/tenon', plural_table_name))

        actions = %w(
          index.html.haml new.html.haml edit.html.haml _form.html.haml
        )

        actions.each do |action|
          src_path = File.join(self.class.source_root, "view_#{action}")
          next unless File.exist?(src_path)
          template(
            "view_#{action}",
            File.join('app/views/tenon', plural_table_name, action)
          )
        end

        %w( decorator policy serializer ).each do |file_type|
          template(
            "#{file_type}.rb",
            File.join(
              "app/#{file_type.pluralize}",
              "#{file_name}_#{file_type}.rb"
            )
          )
        end

        template(
          'controller.rb',
          File.join(
            'app/controllers/tenon',
            "#{file_name.pluralize}_controller.rb"
          )
        )
      end

      def add_routes
        case behavior
        when :invoke
          # Prepare the routes
          filename = File.join(Rails.root, 'config', 'routes.rb')
          pattern = 'Tenon::Engine.routes.draw do'
          reorder = attributes.select { |a| a.name == 'list_order' }.empty? ? '' : "do \n    post    'reorder', on: :collection \n    end"
          contents = File.read(filename)

          # Write the initial Tenon routes block if it's not there already
          unless contents.match(pattern)
            new_contents = "#{contents}\n\nTenon::Engine.routes.draw do\nend\n"
            File.open(filename, 'w') do |f|
              f.puts new_contents
            end
            contents = new_contents
          end

          # Then write the new route
          replacement = "Tenon::Engine.routes.draw do\n  resources :#{plural_table_name} #{reorder}"
          converted_content = contents.gsub(pattern, replacement)
          File.open(filename, 'w') do |f|
            f.write converted_content
          end
        when :revoke
          say 'Be sure to clean up your routes!', :red
        end
      end

      def add_i18n
        filename = File.join(Rails.root, 'config', 'i18n_fields.yml')

        case behavior
        when :invoke
          # Write a couple of lines to config/i18n_fields.yml
          pattern = 'tables:'
          replacement = "tables:\n  #{plural_table_name}:\n    -\n"
          if File.exist?(filename)
            puts 'Wrote I18n fields config'
          else
            puts 'Skipped I18n fields config'
          end
        when :revoke
          # now remove them
          pattern = /^  #{plural_table_name}:\n(    - *[\w]*\n*)*/
          replacement = ''
        end

        if File.exist?(filename)
          converted_content = File.read(filename).gsub(pattern, replacement)
          File.open(filename, 'w') { |f| f.write converted_content }
        end
      end

      def add_menu_item
        case behavior
        when :invoke
          say 'Add the following line to app/views/tenon/shared/_main_nav.html.haml:'
          say " = nav_item '#{class_name.pluralize.titleize}', #{plural_name}_path, 'star'"
        when :revoke
          say %(Don't forget to remove the nav_item entry from app/views/tenon/shared/_main_nav.html.haml)
        end
      end

      no_tasks do
        def collections
          return @collections if @collections
          collections = attributes.select { |a| a.name.match(/_id$/) }
          collections = collections.map { |a| a.name.gsub(/_id$/, '') }
          @collections = collections.uniq
        end

        def assets
          @assets ||= attributes.select { |a| a.type.to_s == 'asset' }
        end

        def text_fields
          return @text_fields if @text_fields
          @text_fields = attributes.select { |a| a.type.to_s == 'string' }
          @text_fields -= seo_fields
        end

        def text_areas
          return @text_areas if @text_areas
          @text_areas = attributes.select { |a| a.type.to_s == 'text' }
          @text_areas -= seo_fields
        end

        def timestamps
          @timestamps ||= attributes.select do |a|
            %w(datetime timestamp).include?(a.type.to_s) &&
              a.name != 'publish_at'
          end
        end

        def dates
          @dates ||= attributes.select { |a| a.type.to_s == 'date' }
        end

        def booleans
          @booleans ||= attributes.select { |a| a.type.to_s == 'boolean' }
        end

        def numbers
          @numbers ||= attributes.select do |a|
            %w(float integer decimal).include?(a.type.to_s) &&
              !a.name.match(/.*_id$/) &&
              a.name != 'list_order'
          end
        end

        def seo_fields
          return @seo_fields if @seo_fields
          names = %w(seo_title seo_keywords seo_description)
          @seo_fields = attributes.select { |a| names.include?(a.name) }
        end

        def tenon_contents
          @tenon_contents ||= attributes.select { |a| a.type.to_s == 'content' }
        end

        def reorderable?
          return @reorderable if @reorderable
          @reorderable = attributes.any? { |a| a.name.to_s == 'list_order' }
        end
      end
    end
  end
end
