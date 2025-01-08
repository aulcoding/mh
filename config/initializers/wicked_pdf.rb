# config/initializers/wicked_pdf.rb
WickedPdf.configure do |config|
  config.exe_path = Rails.root.join('bin', 'wkhtmltopdf').to_s
end
