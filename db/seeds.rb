puts "Seeding BeachCamp..."

organizer1 = User.create!(
  first_name: "Maria", last_name: "Santos",
  email: "maria@beachcamp.com", password: "password123",
  role: :organizer, level: :pro
)

organizer2 = User.create!(
  first_name: "Lucas", last_name: "Weber",
  email: "lucas@beachcamp.com", password: "password123",
  role: :organizer, level: :international
)

players = [
  { first_name: "Alex", last_name: "Johnson", email: "alex@example.com", level: :beginner },
  { first_name: "Sophie", last_name: "Martin", email: "sophie@example.com", level: :intermediate },
  { first_name: "Carlos", last_name: "Rodriguez", email: "carlos@example.com", level: :advanced },
  { first_name: "Emma", last_name: "Thompson", email: "emma@example.com", level: :pro },
  { first_name: "Kenji", last_name: "Tanaka", email: "kenji@example.com", level: :intermediate },
  { first_name: "Lucia", last_name: "Rossi", email: "lucia@example.com", level: :beginner },
  { first_name: "Pierre", last_name: "Dupont", email: "pierre@example.com", level: :advanced },
  { first_name: "Anna", last_name: "Novak", email: "anna@example.com", level: :pro }
].map do |attrs|
  User.create!(attrs.merge(password: "password123", role: :player))
end

admin = User.create!(
  first_name: "Admin", last_name: "BeachCamp",
  email: "admin@beachcamp.com", password: "password123",
  role: :admin, level: :international
)

camps_data = [
  {
    organizer: organizer1, title: "Copacabana Summer Intensive",
    description: "Five days of intensive beach volleyball training on the legendary Copacabana beach. Perfect for intermediate and advanced players looking to take their game to the next level. Daily sessions include technique drills, tactical play, and match simulations.",
    location: "Copacabana Beach", country: "Brazil",
    start_date: 45.days.from_now, end_date: 50.days.from_now,
    level: :intermediate, price_cents: 49_900, currency: "EUR",
    min_participants: 4, max_participants: 12, status: :published, featured: true
  },
  {
    organizer: organizer1, title: "Beginner Beach Camp Lisbon",
    description: "Start your beach volleyball journey on the beautiful beaches of Lisbon! Our beginner-friendly camp covers all fundamentals: passing, setting, hitting, and serving. No experience needed.",
    location: "Carcavelos Beach", country: "Portugal",
    start_date: 30.days.from_now, end_date: 34.days.from_now,
    level: :beginner, price_cents: 29_900, currency: "EUR",
    min_participants: 6, max_participants: 16, status: :published, featured: true
  },
  {
    organizer: organizer2, title: "Pro Training Camp Rimini",
    description: "Elite training camp for professional and aspiring professional players. Work with international-level coaches on advanced strategies, game analysis, and peak performance techniques.",
    location: "Rimini Beach", country: "Italy",
    start_date: 60.days.from_now, end_date: 67.days.from_now,
    level: :pro, price_cents: 89_900, currency: "EUR",
    min_participants: 4, max_participants: 8, status: :published, featured: true
  },
  {
    organizer: organizer2, title: "Barcelona Beach Week",
    description: "A week-long beach volleyball experience on the stunning Barcelona coast. Mixed levels welcome. Includes technique workshops, friendly tournaments, and beach social events.",
    location: "Barceloneta Beach", country: "Spain",
    start_date: 20.days.from_now, end_date: 27.days.from_now,
    level: :beginner, price_cents: 39_900, currency: "EUR",
    min_participants: 8, max_participants: 20, status: :published, featured: false
  },
  {
    organizer: organizer1, title: "Advanced Camp Gold Coast",
    description: "Push your limits at the Gold Coast! This advanced camp focuses on high-level tactics, blocking, defense systems, and sand conditioning.",
    location: "Gold Coast", country: "Australia",
    start_date: 90.days.from_now, end_date: 96.days.from_now,
    level: :advanced, price_cents: 59_900, currency: "EUR",
    min_participants: 4, max_participants: 10, status: :published, featured: false
  },
  {
    organizer: organizer2, title: "International Camp Cancun",
    description: "The ultimate international beach volleyball camp. Train alongside players from around the world. FIVB-certified coaches, world-class facilities, and unforgettable beach volleyball experiences.",
    location: "Cancun Beach", country: "Mexico",
    start_date: 75.days.from_now, end_date: 82.days.from_now,
    level: :international, price_cents: 129_900, currency: "EUR",
    min_participants: 4, max_participants: 12, status: :published, featured: true
  },
  {
    organizer: organizer1, title: "Draft Camp (unpublished)",
    description: "This camp is still being prepared.",
    location: "Nice Beach", country: "France",
    start_date: 120.days.from_now, end_date: 125.days.from_now,
    level: :intermediate, price_cents: 35_000, currency: "EUR",
    min_participants: 4, max_participants: 12, status: :draft, featured: false
  }
]

camps = camps_data.map { |data| Camp.create!(data) }

published_camps = camps.select(&:published?)
published_camps.each do |camp|
  eligible = players.select { |p| User.levels[p.level] <= Camp.levels[camp.level] + 1 }
  eligible.sample([eligible.size, camp.max_participants - 1].min).each do |player|
    Registration.create!(user: player, camp: camp, status: :confirmed)
  rescue ActiveRecord::RecordInvalid
    next
  end
end

convo_camp = published_camps.first
convo = Conversation.create!(camp: convo_camp)
organizer_user = convo_camp.organizer
registered = convo_camp.registrations.first&.user

if registered
  Message.create!(conversation: convo, user: organizer_user, body: "Welcome everyone! Looking forward to an amazing camp. Any questions?")
  Message.create!(conversation: convo, user: registered, body: "Hi! Can't wait. Should I bring my own volleyball?")
  Message.create!(conversation: convo, user: organizer_user, body: "Nope, we've got all equipment covered. Just bring sunscreen and water!")
end

puts "Seeded: #{User.count} users, #{Camp.count} camps, #{Registration.count} registrations, #{Conversation.count} conversations, #{Message.count} messages"
puts ""
puts "Login credentials:"
puts "  Organizer: maria@beachcamp.com / password123"
puts "  Organizer: lucas@beachcamp.com / password123"
puts "  Player:    alex@example.com / password123"
puts "  Admin:     admin@beachcamp.com / password123"
