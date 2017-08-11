namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    # roda o comando antes do resto da task
    puts "Resetando o Banco de Dados"
    %x(rake db:drop db:create db:migrate)

    puts "Criando Tipos"
    kinds = %w(Amigo Comercial Conhecido)
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Tipos criados com sucesso!"

    puts "Cadastrando contatos de teste"
    100.times do |i|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(65.years.ago, 18.years.ago),
        kind: Kind.all.sample
      )
    end
    puts "Finalizando os cadastros com sucesso!"

    puts "Cadastrando Telefones"
    Contact.all.map do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone, contact: contact)
      end
    end
    puts "Finalizando o cadastro de telefones"

    puts "Cadastrando Endereços"
    Contact.all.map do |contact|
      Adddress.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end
    puts "Finalizando o cadastro de endereços"

  end

end
