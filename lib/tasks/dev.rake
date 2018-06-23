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
        category_id: Category.all.sample.id
        )
    end
    puts "have create #{Restaurant.count} fake restaurant "
  end
end