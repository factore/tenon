module Tenon
  module I18nHelper
    def language_switcher(table)
      if Tenon.config.languages
        if Tenon::I18nLookup.fields[:tables][table]
          select_tag 'current_language', options_for_select([['English', 'en']] + Tenon.config.languages.map { |k, v| [k.to_s.titleize, v] })
        end
      end
    end
  end
end