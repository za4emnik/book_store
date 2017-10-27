path = Rails.env.production? ? 'https://s3.us-east-2.amazonaws.com/bookstoretest' : './public'

user = User.create!(email: 'admin@example.com', password: 'paSsword1', password_confirmation: 'paSsword1', is_admin: true)
user.billing_address = BillingAddress.create!(first_name: 'Vincent', last_name: 'Palmer', address: '2009 Tree Frog Lane', city: 'Longview', zip: 75604, country_id: 227, phone: '903-808-7859')
user.shipping_address = ShippingAddress.create!(use_billing_address: true)

#categories
mobile_development = Category.create!(name: 'Mobile development')
photo = Category.create!(name: 'Photo')
web_design = Category.create!(name: 'Web design')
web_development = Category.create!(name: 'Web development')

#materials
Material.create!(name: 'hardcove')
Material.create!(name: 'glossy paper')
Material.create!(name: 'animal skin')
Material.create!(name: 'palm leaves')
Material.create!(name: 'papyrus')

#authors
Author.create!(first_name: 'Dale', last_name: 'Carnegie', description: "The chapter titles seem, at first, a little manipulative: 'Six ways to make people like you,' '12 ways to win people to your way of thinking.' But the reality of Carnegie's teachings is that none will work if the intent is manipulation. The word 'genuine' appears repeatedly throughout the book. Only with authenticity and honesty will Carnegie's methods work consistently.")
Author.create!(first_name: 'George S.', last_name: 'Clason', description: "The book begins with two men realizing that, while they lived a meager existence, one of their childhood friends had become known as the wealthiest man in Babylon. Despite growing up in similar circumstances, their friend seemed to have created a life of gold while they barely scratched out a living.")
Author.create!(first_name: 'Napoleon', last_name: 'Hill', description: "Shorter and perhaps easier to get through than its multivolume predecessor, Think and Grow Rich is as applicable today as it was when it was first released. The title's principles are founded on Hill's belief in the power of the mind, and his famous quotes, such as, 'Whatever the mind can conceive and believe, it can achieve,' have changed the way millions of people view their lives. When read in its entirety and its principles put into action, Think and Grow Rich not only helps people change their views on life, but also the way they behave and, ultimately, their reality.")
Author.create!(first_name: 'Suze', last_name: 'Orman', description: "n this acclaimed book, Orman challenges readers to face their financial fears and acknowledge the importance of planning for the future. With a three-pronged approach, Orman tackles the mental, physical and spiritual issues that keep people from reaching financial freedom. Also available in audio format, 9 Steps to Financial Freedom encourages personal growth while offering the education necessary to begin the process of building a rich life.")
Author.create!(first_name: 'Stephen', last_name: 'Covey', description: "Unlike many authors of books in this genre, Covey doesn't promise a simple, quick fix for creating a better life. In fact, mastering the seven habits he outlines could take a lifetime. But as with many personal-development efforts, it's what you learn as you work toward becoming a truly effective person that matters.")

def create_book(title, description, category, image, dimensions)
  book = Book.create!(title: title, price: rand(1.0..20.0).round(2), description: description, category: category, year: rand(10.years).seconds.ago.year, dimensions: dimensions[rand(0..4)])
  (1..Author.count-1).to_a.shuffle.first(rand(1..4)).each { |number| book.authors << Author.limit(1).offset(number) }
  (1..Material.count-1).to_a.shuffle.first(rand(1..3)).each { |number| book.materials << Material.limit(1).offset(number) }
  book.pictures << Picture.new(image: File.open("#{path}/uploads/books_examples/#{image}", 'rb'))
  (1..6).to_a.shuffle.first(3).each do |number|
    book.pictures << Picture.new(image: File.open("#{path}/uploads/books_examples/book-large#{number}.jpg", 'rb'))
  end
  book.save!
end

dimensions = Array.new
dimensions << "H:3.4\" x W: 1.9\" x D: 5.5"
dimensions << "H:6.4\" x W: 0.9\" x D: 5.0"
dimensions << "H:4.1\" x W: 1 \" x D: 4.7"
dimensions << "H:2.3\" x W: 0.7 \" x D: 4.3"
dimensions << "H:2.5\" x W: 0.5 \" x D: 3.1"

#books
#mobile category
description = "The fast-growing popularity of Android smartphones and tablets creates a huge opportunities for developers. If you're an experienced developer, you can start creating robust mobile Android apps right away with this professional guide to Android 4 application development. Written by one of Google's lead Android developer advocates, this practical book walks you through a series of hands-on projects that illustrate the features of the Android SDK. That includes all the new APIs introduced in Android 3 and 4, including building for tablets, using the Action Bar, Wi-Fi Direct, NFC Beam, and more."
create_book('Android programming for beginers', description, mobile_development, 'android.png', dimensions)

description = "The fast-growing popularity of Android smartphones and tablets creates a huge opportunities for developers. If you're an experienced developer, you can start creating robust mobile Android apps right away with this professional guide to Android 4 application development. Written by one of Google's lead Android developer advocates, this practical book walks you through a series of hands-on projects that illustrate the features of the Android SDK. That includes all the new APIs introduced in Android 3 and 4, including building for tablets, using the Action Bar, Wi-Fi Direct, NFC Beam, and more."
create_book('Android programming for developers', description, mobile_development, 'android2.jpg', dimensions)


#web development
description = "AVR is a family of microcontrollers developed by Atmel beginning in 1996. These are modified Harvard architecture 8-bit RISC single-chip microcontrollers. AVR was one of the first microcontroller families to use on-chip flash memory for program storage, as opposed to one-time programmable ROM, EPROM, or EEPROM used by other microcontrollers at the time."
create_book('AVR', description, web_development, 'avr.png', dimensions)

description = "Bootstrap was created at Twitter in mid-2010 by @mdo and @fat. Prior to being an open-sourced framework, Bootstrap was known as Twitter Blueprint. A few months into development, Twitter held its first Hack Week and the project exploded as developers of all skill levels jumped in without any external guidance. It served as the style guide for internal tools development at the company for over a year before its public release, and continues to do so today. Originally released on Friday, August 19, 2011, we’ve since had over twenty releases, including two major rewrites with v2 and v3. With Bootstrap 2, we added responsive functionality to the entire framework as an optional stylesheet. Building on that with Bootstrap 3, we rewrote the library once more to make it responsive by default with a mobile first approach."
create_book('Bootstrap 4', description, web_development, 'bootstrap.jpg', dimensions)

description = "Digital Adaptation is a book on digital transformation written by Paul Boag. It looks at how businesses need to adapt for the digital age. If you're frustrated by your boss or colleagues not embracing digital then this is the book for you."
create_book('Digital adaptation', description, web_development, 'd-a.png', dimensions)

description = "Writing code for manipulating Drupal data has never been easier! Learn to dice and serve your data as you slowly peel back the layers of the Drupal entity onion. Next, expose your legacy local and remote data to take full advantage of Drupal's vast solution space. Programming Drupal 7 Entities is a practical, hands-on guide that provides you with a thorough knowledge of Drupal's entity paradigm and a number of clear step-by-step exercises, which will help you take advantage of the real power that is available when developing using entities.This book looks at the Drupal 7 entity paradigm, and breaks down the mystery and confusion that developers face when building custom solutions using entities. It will take you through a number of clear, practical recipes that will help you to take full advantage of Drupal entities in your web solutions without much coding."
create_book('Programming Drupal 7', description, web_development, 'drupal7.jpg', dimensions)

description = "Are you new to JavaScript? Or have you added scripts to your web page but want a better idea of how they work? Then this book is for you. We'll not only show you how to read and write JavaScript, but we’ll also teach you the basics of computer programming in a simple, visual way. All you need is a basic understanding of HTML and CSS."
create_book('JavaScript & JQuery', description, web_development, 'jquery.jpg', dimensions)

description = "Functional programming (often abbreviated FP) is the process of building software by composing pure functions, avoiding shared state, mutable data, and side-effects. Functional programming is declarative rather than imperative, and application state flows through pure functions. Contrast with object oriented programming, where application state is usually shared and colocated with methods in objects."
create_book('Functional programming in javascript', description, web_development, 'js.png', dimensions)

description = "We believe programming should be fun to learn. You'll LEARN BY DOING right from the beginning. This book features a lot of practical Laravel tutorials. Each tutorial includes practical advice, tips and tricks for working with jQuery, AJAX, JSON, API, modular PHP, testing, deployment and more. The book now supports the latest version of Laravel!"
create_book('Laravel 5 Cookbook', description, web_development, 'laravel.jpg', dimensions)

description = "The aim of this document is to get you started with developing applications with Node.js, teaching you everything you need to know about 'advanced' JavaScript along the way. It goes way beyond your typical 'Hello World' tutorial."
create_book('Node.js projects', description, web_development, 'node-js.jpg', dimensions)

description = "Smarty is a templating engine for PHP. Designers who are used to working with HTML files can work with Smarty templates, which are HTML files with simple tags while programmers work with the underlying PHP code. The Smarty engine brings the code and templates together. The result of all this is that designers can concentrate on designing, programmers can concentrate on programming, and they don't need to get in each others way so much.Even if you are developing a site on your own, Smarty is a powerful way to make your code clearer to you and others, as well as easier to debug and modify later.Visit the Free Online Edition for Smarty PHP Template Programming and Applications and learn more about the book and discover what each chapter from this book has in store."
create_book('Smarty', description, web_development, 'php.jpg', dimensions)

description = "Ace your preparation for Microsoft Certification Exam 70-461 with this 2-in-1 Training Kit from Microsoft Press. Work at your own pace through a series of lessons and practical exercises, and then assess your skills with practice tests on CD–featuring multiple, customizable testing options."
create_book('SQL Server 2016', description, web_development, 'sql.jpg', dimensions)


#design
description = "In this track, you’ll learn how to design and build beautiful websites by learning the basic principles of design like branding, color theory, and typography which are all instrumental in the design process of a website. You’ll also learn HTML and CSS, which are the common code languages that all modern websites are built on. These are useful skills to acquire as they are needed by nearly every single business in the world to communicate to customers. By the end of this track, you’ll have all the skills required to design and build your own websites or even start a career with one of the thousands of companies that have a website."
create_book('Learning web design', description, web_design, 'design.png', dimensions)

description = "In this track, you’ll learn how to design and build beautiful websites by learning the basic principles of design like branding, color theory, and typography which are all instrumental in the design process of a website. You’ll also learn HTML and CSS, which are the common code languages that all modern websites are built on. These are useful skills to acquire as they are needed by nearly every single business in the world to communicate to customers. By the end of this track, you’ll have all the skills required to design and build your own websites or even start a career with one of the thousands of companies that have a website."
create_book('Learning material design', description, web_design, 'learning-design.png', dimensions)

description = "This second edition of The Principles of Beautiful Web Design is the ideal book for people who can build websites, but are seeking the skills and knowledge to visually enhance their sites.  And lots more... This revised, easy-to-follow guide is illustrated with beautiful, full-color examples, and leads readers through the process of creating great designs from start to finish."
create_book('The Principles of Beautiful Web Design', description, web_design, 'principles-of-beautiful-web-design.jpg', dimensions)

description = "Since its groundbreaking release in 2011, Responsive Web Design remains a fundamental resource for anyone working on the web. Learn how to think beyond the desktop, and craft designs that respond to your users’ needs. In the second edition, Ethan Marcotte expands on the design principles behind fluid grids, flexible images, and media queries. Through new examples and updated facts and figures, you’ll learn how to deliver a quality experience, no matter how large or small the display."
create_book('Responsive Web Design', description, web_design, 'res-web-design.jpg', dimensions)

description = "Web design encompasses many different skills and disciplines in the production and maintenance of websites. The different areas of web design include web graphic design; interface design; authoring, including standardised code and proprietary software; user experience design; and search engine optimization."
create_book('Web design', description, web_design, 'web-design.png', dimensions)

#photo
description = "An instant Number One New York Times bestseller, Humans of New York began in the summer of 2010, when photographer Brandon Stanton set out on an ambitious project: to single-handedly create a photographic census of New York City. Armed with his camera, he began crisscrossing the city, covering thousands of miles on foot, all in his attempt to capture ordinary New Yorkers in the most extraordinary of moments."
create_book('Humans of New York', description, photo, 'humans.jpg', dimensions)

description = "Chanel's combination of tradition, originality and style has always made it the most seductive of brands. Here the House of Chanel opens its private archives, revealing a galaxy of brilliant designs created by Coco Chanel from 1920 onwards. Dazzling clothes, intricate accessories, beautiful models and timeless design leave no doubt as to the lasting fame of the brand and embody everything that has come to symbolize the magic of Chanel."
create_book('Chanel : Collections and Creations', description, photo, 'chanel.jpg', dimensions)

description = "Now a #1 New York Times Bestseller! In the summer of 2010, photographer Brandon Stanton began an ambitious project -to single-handedly create a photographic census of New York City. The photos he took and the accompanying interviews became the blog Humans of New York. His audience steadily grew from a few hundred followers to, at present count, over eighteen million. In 2013, his book Humans of New York, based on that blog, was published and immediately catapulted to the top of the NY Times Bestseller List where it has appeared for over forty-five weeks. Now, Brandon is back with the Humans of New York book that his loyal followers have been waiting for: Humans of New York: Stories. Ever since Brandon began interviewing people on the streets of New York, the dialogue he's had with them has increasingly become as in-depth, intriguing and moving as the photos themselves."
create_book('Humans of New York: Stories', description, photo, 'humans-ny-stories.jpg', dimensions)

description = "Susan Sontag's On Photography is a seminal and groundbreaking work on the subject. Susan Sontag's groundbreaking critique of photography asks forceful questions about the moral and aesthetic issues surrounding this art form. Photographs are everywhere, and the 'insatiability of the photographing eye' has profoundly altered our relationship with the world. Photographs have the power to shock, idealize or seduce, they create a sense of nostalgia and act as a memorial, and they can be used as evidence against us or to identify us. In these six incisive essays, Sontag examines the ways in which we use these omnipresent images to manufacture a sense of reality and authority in our lives."
create_book('On Photography', description, photo, 'on-photography.jpg', dimensions)

description = "In Bloom, Estee shares the moments, people, things and life lessons that have made her who she is today and offers her tips for surviving life. Celebrate your bloom story and what makes you unique: Life; People; Work; Beauty; Fashion; Home; Travel; Food. "
create_book('Bloom : navigating life and style', description, photo, 'bloom.jpg', dimensions)


#coupons
Coupon.create!(code: 'qwerty123', value: '51,1')

#deliveries
Delivery.create!(name: 'Delivery Next Day!', interval: '3 to 7 days', price: '28,50')
Delivery.create!(name: 'Free!', interval: '10 days', price: '0')

#orders
order = Order.create!(user: user, delivery: Delivery.order("RANDOM()").first, aasm_state: 'delivered')
Category.all.each do |category|
  Book.where(category_id: category.id).order("RANDOM()").first(3).each do |book|
    order.order_items << OrderItem.create(book: book, quantity: rand(1..5))
  end
end
order.cart = Cart.create(number: '4539 7544 3086 5687', name: 'CONNOR KELLY', date: '03/19', cvv: '582')
order.billing_address = BillingAddress.create!(first_name: 'Tomiko', last_name: 'Gulgowski', address: '8663 Vernell Spur', city: 'Lake Anneberg', zip: 75604, country_id: rand(1..245), phone: '903-808-7859')
order.subtotal!
order.update_total!
order.save!

order = Order.create!(user: user, delivery: Delivery.order("RANDOM()").first, aasm_state: 'in_progress')
Book.order("RANDOM()").first(3).each do |book|
  order.order_items << OrderItem.create(book: book, quantity: rand(1..5))
end
order.cart = Cart.create(number: '4024 0071 4207 9887', name: 'CHARLES VANCE', date: '05/18', cvv: '328')
order.billing_address = BillingAddress.create!(first_name: 'Tomiko', last_name: 'Gulgowski', address: '8663 Vernell Spur', city: 'Lake Anneberg', zip: 75604, country_id: rand(1..245), phone: '903-808-7859')
order.shipping_address = ShippingAddress.create!(first_name: 'Tomiko', last_name: 'Gulgowski', address: '8663 Vernell Spur', city: 'Lake Anneberg', zip: 75604, country_id: rand(1..245), phone: '903-808-7859')
order.subtotal!
order.update_total!
order.save!

order = Order.create!(user: user, delivery: Delivery.order("RANDOM()").first, aasm_state: 'waiting_for_processing')
Book.order("RANDOM()").first(2).each do |book|
  order.order_items << OrderItem.create(book: book, quantity: rand(1..5))
end
order.cart = Cart.create(number: '5573 6641 8757 5708', name: 'KATHERINE ROBERTS', date: '04/19', cvv: '215')
order.billing_address = BillingAddress.create!(first_name: 'Tomiko', last_name: 'Gulgowski', address: '8663 Vernell Spur', city: 'Lake Anneberg', zip: 75604, country_id: rand(1..245), phone: '903-808-7859')
order.shipping_address = ShippingAddress.create!(first_name: 'Tomiko', last_name: 'Gulgowski', address: '8663 Vernell Spur', city: 'Lake Anneberg', zip: 75604, country_id: rand(1..245), phone: '903-808-7859')
order.subtotal!
order.update_total!
order.save!

7.times do
  order = Order.create!(user: user, delivery: Delivery.order("RANDOM()").first, aasm_state: 'delivered')
  Book.order("RANDOM()").first(5).each do |book|
    order.order_items << OrderItem.create(book: book, quantity: rand(1..5))
  end
  order.cart = Cart.create(number: '3765 153926 73359', name: 'SAMUEL TIMMONS', date: '08/18', cvv: '529')
  order.billing_address = BillingAddress.create!(first_name: 'Tomiko', last_name: 'Gulgowski', address: '8663 Vernell Spur', city: 'Lake Anneberg', zip: 75604, country_id: rand(1..245), phone: '903-808-7859')
  order.subtotal!
  order.update_total!
  order.save!
end

#reviews
reviews_states = ['unprocessed', 'approved', 'rejected']
30.times do
  Review.create!(title: 'some review', score: rand(1..5).to_s, message: 'Laudantium explicabo et corporis soluta rem ad. Qui nostrum laboriosam quae voluptatum pariatur sapiente rerum voluptatem. Non unde et molestiae id et.', book: Book.order("RANDOM()").first, user: User.order("RANDOM()").first, aasm_state: reviews_states[rand(0..2)])
end

#countries
Country.create!(name: 'Afghanistan')
Country.create!(name: 'Albania')
Country.create!(name: 'Algeria')
Country.create!(name: 'American Samoa')
Country.create!(name: 'Andorra')
Country.create!(name: 'Angola')
Country.create!(name: 'Anguilla')
Country.create!(name: 'Antarctica')
Country.create!(name: 'Antigua and Barbuda')
Country.create!(name: 'Argentina')
Country.create!(name: 'Armenia')
Country.create!(name: 'Aruba')
Country.create!(name: 'Australia')
Country.create!(name: 'Austria')
Country.create!(name: 'Azerbaijan')
Country.create!(name: 'Bahamas')
Country.create!(name: 'Bahrain')
Country.create!(name: 'Bangladesh')
Country.create!(name: 'Barbados')
Country.create!(name: 'Belarus')
Country.create!(name: 'Belgium')
Country.create!(name: 'Belize')
Country.create!(name: 'Benin')
Country.create!(name: 'Bermuda')
Country.create!(name: 'Bhutan')
Country.create!(name: 'Bolivia')
Country.create!(name: 'Bosnia and Herzegovina')
Country.create!(name: 'Botswana')
Country.create!(name: 'Bouvet Island')
Country.create!(name: 'Brazil')
Country.create!(name: 'British Indian Ocean Territory')
Country.create!(name: 'Brunei Darussalam')
Country.create!(name: 'Bulgaria')
Country.create!(name: 'Burkina Faso')
Country.create!(name: 'Burundi')
Country.create!(name: 'Cambodia')
Country.create!(name: 'Cameroon')
Country.create!(name: 'Canada')
Country.create!(name: 'Cape Verde')
Country.create!(name: 'Cayman Islands')
Country.create!(name: 'Central African Republic')
Country.create!(name: 'Chad')
Country.create!(name: 'Chile')
Country.create!(name: 'China')
Country.create!(name: 'Christmas Island')
Country.create!(name: 'Cocos (Keeling) Islands')
Country.create!(name: 'Colombia')
Country.create!(name: 'Comoros')
Country.create!(name: 'Congo')
Country.create!(name: 'Cook Islands')
Country.create!(name: 'Costa Rica')
Country.create!(name: 'Croatia (Hrvatska)')
Country.create!(name: 'Cuba')
Country.create!(name: 'Cyprus')
Country.create!(name: 'Czech Republic')
Country.create!(name: 'Denmark')
Country.create!(name: 'Djibouti')
Country.create!(name: 'Dominica')
Country.create!(name: 'Dominican Republic')
Country.create!(name: 'East Timor')
Country.create!(name: 'Ecuador')
Country.create!(name: 'Egypt')
Country.create!(name: 'El Salvador')
Country.create!(name: 'Equatorial Guinea')
Country.create!(name: 'Eritrea')
Country.create!(name: 'Estonia')
Country.create!(name: 'Ethiopia')
Country.create!(name: 'Falkland Islands (Malvinas)')
Country.create!(name: 'Faroe Islands')
Country.create!(name: 'Fiji')
Country.create!(name: 'Finland')
Country.create!(name: 'France')
Country.create!(name: 'France, Metropolitan')
Country.create!(name: 'French Guiana')
Country.create!(name: 'French Polynesia')
Country.create!(name: 'French Southern Territories')
Country.create!(name: 'Gabon')
Country.create!(name: 'Gambia')
Country.create!(name: 'Georgia')
Country.create!(name: 'Germany')
Country.create!(name: 'Ghana')
Country.create!(name: 'Gibraltar')
Country.create!(name: 'Guernsey')
Country.create!(name: 'Greece')
Country.create!(name: 'Greenland')
Country.create!(name: 'Grenada')
Country.create!(name: 'Guadeloupe')
Country.create!(name: 'Guam')
Country.create!(name: 'Guatemala')
Country.create!(name: 'Guinea')
Country.create!(name: 'Guinea-Bissau')
Country.create!(name: 'Guyana')
Country.create!(name: 'Haiti')
Country.create!(name: 'Heard and Mc Donald Islands')
Country.create!(name: 'Honduras')
Country.create!(name: 'Hong Kong')
Country.create!(name: 'Hungary')
Country.create!(name: 'Iceland')
Country.create!(name: 'India')
Country.create!(name: 'Isle of Man')
Country.create!(name: 'Indonesia')
Country.create!(name: 'Iran (Islamic Republic of)')
Country.create!(name: 'Iraq')
Country.create!(name: 'Ireland')
Country.create!(name: 'Israel')
Country.create!(name: 'Italy')
Country.create!(name: 'Ivory Coast')
Country.create!(name: 'Jersey')
Country.create!(name: 'Jamaica')
Country.create!(name: 'Japan')
Country.create!(name: 'Jordan')
Country.create!(name: 'Kazakhstan')
Country.create!(name: 'Kenya')
Country.create!(name: 'Kiribati')
Country.create!(name: 'Korea, Democratic People\'\'s Republic of')
Country.create!(name: 'Korea, Republic of')
Country.create!(name: 'Kosovo')
Country.create!(name: 'Kuwait')
Country.create!(name: 'Kyrgyzstan')
Country.create!(name: 'Lao People''s Democratic Republic')
Country.create!(name: 'Latvia')
Country.create!(name: 'Lebanon')
Country.create!(name: 'Lesotho')
Country.create!(name: 'Liberia')
Country.create!(name: 'Libyan Arab Jamahiriya')
Country.create!(name: 'Liechtenstein')
Country.create!(name: 'Lithuania')
Country.create!(name: 'Luxembourg')
Country.create!(name: 'Macau')
Country.create!(name: 'Macedonia')
Country.create!(name: 'Madagascar')
Country.create!(name: 'Malawi')
Country.create!(name: 'Malaysia')
Country.create!(name: 'Maldives')
Country.create!(name: 'Mali')
Country.create!(name: 'Malta')
Country.create!(name: 'Marshall Islands')
Country.create!(name: 'Martinique')
Country.create!(name: 'Mauritania')
Country.create!(name: 'Mauritius')
Country.create!(name: 'Mayotte')
Country.create!(name: 'Mexico')
Country.create!(name: 'Micronesia, Federated States of')
Country.create!(name: 'Moldova, Republic of')
Country.create!(name: 'Monaco')
Country.create!(name: 'Mongolia')
Country.create!(name: 'Montenegro')
Country.create!(name: 'Montserrat')
Country.create!(name: 'Morocco')
Country.create!(name: 'Mozambique')
Country.create!(name: 'Myanmar')
Country.create!(name: 'Namibia')
Country.create!(name: 'Nauru')
Country.create!(name: 'Nepal')
Country.create!(name: 'Netherlands')
Country.create!(name: 'Netherlands Antilles')
Country.create!(name: 'New Caledonia')
Country.create!(name: 'New Zealand')
Country.create!(name: 'Nicaragua')
Country.create!(name: 'Niger')
Country.create!(name: 'Nigeria')
Country.create!(name: 'Niue')
Country.create!(name: 'Norfolk Island')
Country.create!(name: 'Northern Mariana Islands')
Country.create!(name: 'Norway')
Country.create!(name: 'Oman')
Country.create!(name: 'Pakistan')
Country.create!(name: 'Palau')
Country.create!(name: 'Palestine')
Country.create!(name: 'Panama')
Country.create!(name: 'Papua New Guinea')
Country.create!(name: 'Paraguay')
Country.create!(name: 'Peru')
Country.create!(name: 'Philippines')
Country.create!(name: 'Pitcairn')
Country.create!(name: 'Poland')
Country.create!(name: 'Portugal')
Country.create!(name: 'Puerto Rico')
Country.create!(name: 'Qatar')
Country.create!(name: 'Reunion')
Country.create!(name: 'Romania')
Country.create!(name: 'Russian Federation')
Country.create!(name: 'Rwanda')
Country.create!(name: 'Saint Kitts and Nevis')
Country.create!(name: 'Saint Lucia')
Country.create!(name: 'Saint Vincent and the Grenadines')
Country.create!(name: 'Samoa')
Country.create!(name: 'San Marino')
Country.create!(name: 'Sao Tome and Principe')
Country.create!(name: 'Saudi Arabia')
Country.create!(name: 'Senegal')
Country.create!(name: 'Serbia')
Country.create!(name: 'Seychelles')
Country.create!(name: 'Sierra Leone')
Country.create!(name: 'Singapore')
Country.create!(name: 'Slovakia')
Country.create!(name: 'Slovenia')
Country.create!(name: 'Solomon Islands')
Country.create!(name: 'Somalia')
Country.create!(name: 'South Africa')
Country.create!(name: 'South Georgia South Sandwich Islands')
Country.create!(name: 'Spain')
Country.create!(name: 'Sri Lanka')
Country.create!(name: 'St. Helena')
Country.create!(name: 'St. Pierre and Miquelon')
Country.create!(name: 'Sudan')
Country.create!(name: 'Suriname')
Country.create!(name: 'Svalbard and Jan Mayen Islands')
Country.create!(name: 'Swaziland')
Country.create!(name: 'Sweden')
Country.create!(name: 'Switzerland')
Country.create!(name: 'Syrian Arab Republic')
Country.create!(name: 'Taiwan')
Country.create!(name: 'Tajikistan')
Country.create!(name: 'Tanzania, United Republic of')
Country.create!(name: 'Thailand')
Country.create!(name: 'Togo')
Country.create!(name: 'Tokelau')
Country.create!(name: 'Tonga')
Country.create!(name: 'Trinidad and Tobago')
Country.create!(name: 'Tunisia')
Country.create!(name: 'Turkey')
Country.create!(name: 'Turkmenistan')
Country.create!(name: 'Turks and Caicos Islands')
Country.create!(name: 'Tuvalu')
Country.create!(name: 'Uganda')
Country.create!(name: 'Ukraine')
Country.create!(name: 'United Arab Emirates')
Country.create!(name: 'United Kingdom')
Country.create!(name: 'United States')
Country.create!(name: 'United States minor outlying islands')
Country.create!(name: 'Uruguay')
Country.create!(name: 'Uzbekistan')
Country.create!(name: 'Vanuatu')
Country.create!(name: 'Vatican City State')
Country.create!(name: 'Venezuela')
Country.create!(name: 'Vietnam')
Country.create!(name: 'Virgin Islands (British)')
Country.create!(name: 'Virgin Islands (U.S.)')
Country.create!(name: 'Wallis and Futuna Islands')
Country.create!(name: 'Western Sahara')
Country.create!(name: 'Yemen')
Country.create!(name: 'Zaire')
Country.create!(name: 'Zambia')
Country.create!(name: 'Zimbabwe')
