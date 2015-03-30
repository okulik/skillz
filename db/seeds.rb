# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email

require 'faker'

skills = ['A+', 'ALGOL', 'APL', 'ActionScript', 'Ada', 'Alice', 'Ant', 'Ateji PX', 'BASIC', 'BCPL', 'Befunge', 'Blue', 'Brainfuck', 'C', 'C#', 'C++', 'CLEO', 'CLIPPER 5.3', 'COBOL', 'Caché', 'Candle', 'Chapel', 'Charity', 'Chef', 'Clarion', 'Clean', 'Clipper', 'Cobra', 'Common Lisp', 'Coq (Gallina)', 'Curl', 'Curry', 'D', 'DASL', 'DIBOL', 'Delphi', 'Dylan', 'Eiffel', 'Elm', 'Emacs Lisp', 'Erlang', 'Factor', 'Fancy', 'Forth', 'Fortran', 'Frege', 'Go', 'Gosu', 'Groovy', 'Harbour', 'Haskell', 'Hope', 'IDL', 'INTERCAL', 'Idris', 'J', 'JOVIAL', 'Java', 'Julia', 'K', 'LOLCODE', 'LabVIEW', 'Lustre', 'ML', 'MUMPS', 'Malbolge', 'Matlab', 'Mercury', 'MetaPost', 'Miranda', 'Modelica', 'Nemerle', 'OCaml', 'Obix', 'Objective-C', 'Octave', 'Oz', 'Pascal', 'Piet', 'Plus', 'Prolog', 'Python', 'R', 'RDQL', 'RPG', 'Rust', 'S', 'S-Lang', 'SMALL', 'SPARQL', 'SQL', 'Sather', 'Scala', 'Scheme', 'SequenceL', 'Shakespeare', 'Simula', 'Smalltalk', 'Standard ML', 'Swift', 'Turing', 'Ubercode', 'Vala', 'Visual Basic', 'Visual FoxPro', 'Visual Prolog', 'WebDNA', 'WebQL', 'Whitespace', 'WinDev', 'X#', 'X++', 'X10', 'XL', 'XSL-T', 'Z++', 'ZPL', 'dBase', 'xBase']

prng = Random.new
worker_count = customer_count = 10000
rc = Worker.connection.raw_connection

rc.exec("COPY workers(id,name,skills,created_at,updated_at) FROM STDIN WITH CSV")
names = []
worker_count.times do |i|
  name = "#{Faker::Name.name} #{i+1}"
  names << name
  rc.put_copy_data("\"#{i+1}\",\"#{name}\",\"{#{skills.sample(prng.rand(2..10)).join(',')}}\",\"#{Time.now}\",\"#{Time.now}\"\n")
end
rc.put_copy_end

rc.exec("COPY users(id,email,encrypted_password,rolable_id,rolable_type,created_at,updated_at) FROM STDIN WITH CSV")
worker_count.times do |i|
  rc.put_copy_data("\"#{i+1}\",\"#{Faker::Internet.safe_email(names[i])}\",\"$2a$10$VMLwDO0ETqyQjt0l.SMmRuImlAYtfdpr1kybqQVwsbjzuVERX14R.\",\"#{i+1}\",\"Worker\",\"#{Time.now}\",\"#{Time.now}\"\n")
end
rc.put_copy_end

rc.exec("COPY customers(id,name,created_at,updated_at) FROM STDIN WITH CSV")
names = []
customer_count.times do |i|
  name = "#{Faker::Name.name} #{i+worker_count+1}"
  names << name
  rc.put_copy_data("\"#{i+1}\",\"#{name}\",\"#{Time.now}\",\"#{Time.now}\"\n")
end
rc.put_copy_end

rc.exec("COPY users(id,email,encrypted_password,rolable_id,rolable_type,created_at,updated_at) FROM STDIN WITH CSV")
customer_count.times do |i|
  rc.put_copy_data("\"#{i+worker_count+1}\",\"#{Faker::Internet.safe_email(names[i])}\",\"$2a$10$VMLwDO0ETqyQjt0l.SMmRuImlAYtfdpr1kybqQVwsbjzuVERX14R.\",\"#{i+1}\",\"Customer\",\"#{Time.now}\",\"#{Time.now}\"\n")
end
rc.put_copy_end

rc.exec("COPY jobs FROM STDIN WITH CSV")
customer_count.times do |i|
  start_date = Faker::Date.between(1.year.ago, 1.year.since)
  end_date = start_date + prng.rand(90).days
  rc.put_copy_data("\"#{i+1}\",\"#{prng.rand(worker_count)+1}\",\"#{prng.rand(customer_count)+1}\",\"#{Faker::Lorem.sentence}\",\"#{start_date}\", \"#{end_date}\", \"#{Time.now}\",\"#{Time.now}\"\n")
end
rc.put_copy_end

rc.exec("alter sequence workers_id_seq restart with #{worker_count+1}")
rc.exec("alter sequence users_id_seq restart with #{customer_count+worker_count+1}")
rc.exec("alter sequence customers_id_seq restart with #{customer_count+1}")
rc.exec("alter sequence jobs_id_seq restart with #{customer_count+1}")