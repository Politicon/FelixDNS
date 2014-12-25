class Domain
  include DataMapper::Resource
  include DataMapper::Validate

  attr_accessor :deleted

  property :id,            Serial
  property :name,          String,    :required => true
  property :content,       IPAddress, :required => true
  property :cf_record,     Integer,   :required => false # auto-set

  property :created_at,    DateTime
  property :updated_at,    DateTime
  property :deleted_at,    ParanoidDateTime


  belongs_to :account, :required => false

  # Validations
  validates_format_of    :name,     :with => /[0-9a-z]/


  before :save, :create_or_update
  before :destroy, :delete


  def ttl
    @created_at < DateTime.now - 14 ? ttl = 1 : ttl = 120
    logger.debug "TTL = " + ttl.to_s
    ttl
  end


  def connect
    cf = CloudFlare::connection(ENV['CLOUDFLARE_API_KEY'],ENV['CLOUDFLARE_EMAIL'])
    logger.debug cf

    cf
  end



  # FIXME: Throw exception on API failure! and halt
  def create_or_update

    return if @deleted == true

    cf = connect

    if @record_id.nil?
      rec = cf.rec_new('ec.vg','A',name, content, self.ttl)
      logger.debug rec
      self.record_id = rec["response"]["rec"]["obj"]["rec_id"].to_i
    else
      rec = cf.rec_edit('ec.vg', 'A', record_id, name, content, self.ttl, false)
      logger.debug rec
    end

  end

  def delete
    cf = connect
    logger.debug cf.rec_delete('ec.vg', record_id)
    @deleted = true
  end





end
