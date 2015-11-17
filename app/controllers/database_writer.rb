require 'pg'

class DatabaseWriter
  def initialize(email, f_name, l_name, company, job_title, member_rating, last_changed, date_added, active)
    @email = email
    @f_name = f_name
    @l_name = l_name
    @company = company
    @job_title = job_title
    @member_rating = member_rating
    @last_changed = last_changed
    @date_added = date_added
    @active = active
  end

  def connect
    @conn = PG.connect(:hostaddr => "127.0.0.1", :port => 5432, :dbname => "core", :user => "jsong", :password => "FireDrive1!")
  end

  def prepareInsertUserStatement
    @conn.prepare("insert_user", "insert into marketing (email, f_name, l_name, company, job_title, member_rating, last_changed, date_added, active)
                    values ($1, $2, $3, $4, $5, $6, $7, $8, $9)")
  end

  # Add a mailchimp user.
  def addUser()
    @conn.exec_prepared("insert_user", ["#{@email}", "#{@f_name}", "#{@l_name}", "#{@company}", "#{@job_title}",
                                        "#{@member_rating}", "#{@last_changed}", "#{@date_added}", "#{@active}" ])
  end

  # Disconnect the back-end connection.
  def disconnect
    @conn.close
  end
end


db = DatabaseWriter.new('adam@abholt.com','adam','holt','CU Boulder','Student',5,'5/5/12 2:30','6/27/13 5:00',true)
db.connect
db.prepareInsertUserStatement
db.addUser()
db.disconnect