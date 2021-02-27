# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key   = '6Lc4oZ8UAAAAADZG_Dt6NkiPag5nMJlpTrq7IVkZ'
  config.secret_key = '6Lc4oZ8UAAAAABgoneCd8_hqYSJN5S4_8qbR-QOm'
  # Uncomment the following line if you are using a proxy server:
  config.proxy = 'http://127.0.0.1:3000'
end	