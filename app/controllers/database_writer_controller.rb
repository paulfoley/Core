require 'pg'
class DatabaseWriterController < ApplicationController
  def connect
    @conn = PG.connect(:hostaddr => "127.0.0.1", :port => 5432, :dbname => "core", :user => "jsong", :password => "FireDrive1!")
  end

  def prepareInsertUserStatement
    @conn.prepare("insert_user", "insert into marketing (email, f_name, l_name, company, job_title, member_rating, last_changed, date_added, active)
                    values ($1, $2, $3, $4, $5, $6, $7, $8, $9)")
  end

  # Add a mailchimp user.
  def addUser(email, f_name, l_name, company, job_title, member_rating, last_changed, date_added, active)
    @conn.exec_prepared("insert_user", [email, f_name, l_name, company, job_title, member_rating, last_changed, date_added, active])
  end

  # Disconnect the back-end connection.
  def disconnect
    @conn.close
  end
end

def main
  db = DatabaseWriterController.new
  db.connect
  db.prepareInsertUserStatement
  db.addUser('adam@abholt.com','adam','holt','CU Boulder','Student',5,'5/5/12 2:30','6/27/13 5:00',true)
  db.disconnect
end

main
