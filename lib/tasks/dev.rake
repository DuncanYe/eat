namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    100.times do
      Restaurant.create!(
        name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category_id: Category.all.sample.id,
        image: File.open(Rails.root.join("seed_img/#{rand(0..3)}.jpg"))
        )
    end
    puts "have create #{Restaurant.count} fake restaurant "
  end

  task fake_user: :environment do

    User.all.each do | user |
      user.destroy unless user.admin?
    end


    10.times do
      user_name = FFaker::Name.first_name
      User.create!(
        email: "#{user_name}@example.com",
        password: "111111"
        )
    end
    puts "Now have #{User.count} user data"
  end

  task fake_comment: :environment do
    Comment.destroy_all

    Restaurant.all.each do |restaurant|
      3.times do
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
          )
      end
    end
    puts "Now have #{Comment.count} comment date"
  end
end