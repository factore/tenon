Tenon.features.S3DirectUpload = class
  constructor: (options) ->
    # @options = $.extend(@defaultOptions, options)
    # @swfuploadOptions = $.extend(@defaultSwfuploadOptions, @options.swfuploadOptions)

    # $(@options.element).swfupload @swfuploadOptions
    # $(@options.element)
    #   .bind('fileQueued',     @options.fileQueued)
    #   .bind('uploadProgress', @options.uploadProgress)
    #   .bind('uploadError',    @options.uploadError)
    #   .bind('uploadSuccess',  @options.uploadSuccess)

  # defaultOptions:
  #   element: '#swfupload-control'
  #   uploadSuccess: (file, data, response) ->
  #     alert "Success"
  #   uploadProgress: (event, file, bytesLoaded) ->
  #     percentage = Math.round((bytesLoaded/file.size)*100);
  #     $('#upload_bar').css('width', percentage + '%');
  #     $('#upload_status').html('Uploading ' + file.name + ': ' + (bytesLoaded / 1024).toFixed(0) + 'kB of ' + (file.size / 1024).toFixed(0) + 'kB.')
  #   uploadComplete: (event, file) ->
  #     $(@options.element).swfupload('startUpload')
  #   uploadError: ->
  #     alert 'error'

  # defaultSwfuploadOptions:
  #   upload_url: 'http://s3.amazonaws.com'
  #   flash_url: '/flash/swfupload.swf'
  #   file_size_limit: '5000 MB'
  #   file_types: '*'
  #   file_types_description: 'Flash Videos'
  #   file_upload_limit: '0'
  #   file_post_name: "file"                  # FOR AWS
  #   http_success: [ 200, 201, 204 ]         # FOR AWS
  #   button_image_url: "/images/tenon/browse.png"
  #   button_width: "110"
  #   button_height: "30"
  #   button_placeholder_id : "swfupload-button"
  #   button_text_left_padding: 12
  #   button_text_top_padding: 3
  #   file_queue_limit: "1"
  #   # debug: true
  #   button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT
