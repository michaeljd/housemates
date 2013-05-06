class User
  include Mongoid::Document
  rolify :role_cname => 'UserRole'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
   :omniauthable, :confirmable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  #field :name,      :type => String
  field :first_name,    :type => String
  field :last_name,    :type => String
  field :image,      :type => String
  field :location,    :type => String

  has_many  :house_mates, :dependent => :destroy

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  def get_image()
    self.image || "http://b.static.ak.fbcdn.net/rsrc.php/v1/yo/r/UlIqmHJn-SK.gif"
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
    if data = session["devise.facebook_data"] && session['devise.facebook_data']['extra']['raw_info']
      user.email = data['email']
    end
  end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nul)
    data = access_token.info
		if user = User.where(:email => data.email).first
			user.image = data.image
			user.first_name = data.first_name
			user.last_name = data.last_name
			user
		else
			self.create(:email => data.email,
				:password => Devise.friendly_token[0,20],
				:image => data.image,
				#:name => data.name,
				:first_name => data.first_name,
				:last_name => data.last_name
				)
		end
  end

  def houses
    houses = Set.new
    self.house_mates.each { |housemate| houses.add(housemate.house) }
    houses
  end

end
