# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w(hotel-new.scss base.js tour-page.js tour-page.scss hotel.js tour-filter.js about.js readmore.js hotels-by-country.css operator.css operators.css about.css static.scss main.css jquery.min.js new2.css jquery.mobile.custom.min.js bootstrap.min.js jasny-bootstrap.min.js moment.js ru.js jquery.easing.js bootstrap-datetimepicker.min.js selectize.min.js jquery.quicksand.js slick.min.js jquery.fancybox.pack.js ion.rangeSlider.min.js jquery.scrollbar.min.js datepicker.js blog.css blog-item.css main.js hotel.css description.css footer.js )
Rails.application.config.assets.precompile += %w(ckeditor/* country.js jquery.maskedinput.min.js)
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
