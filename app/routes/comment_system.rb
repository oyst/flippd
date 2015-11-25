module CommentSystem

  class User
    attr_accessor :id, :name, :email

    def initialize(id, name, email)
      @id = id
      @name = name
      @email = email
    end
  end

  class Comment
    attr_accessor :id, :message, :user, :reply_count, :creation_date

    def initialize(id, message, user, reply_count, creation_date)
      @id = id
      @message = message
      @user = user
      @reply_count = reply_count
      @creation_date = creation_date
    end
  end

  class StubCommentProvider
    @@comments = {}

    def initialize(forum_id, thread_id, test_mode = false)
    end

    def create(user_id, message, reply_id: nil)
    end

    def delete(user_id, comment_id)
    end

    def update(user_id, comment_id, message)
    end

    def get_comments(start: 0, max: 100, order: nil, parent_id: nil)
      if @@comments[parent_id].nil?
        return []
      end
      @@comments[parent_id][start, start+max]
    end

    def count(parent_id: nil)
      if @@comments[parent_id].nil?
        return 0
      end
      @@comments[parent_id].count
    end

    def self.clear_comments
      @@comments = {}
    end

    def self.add_comment(comment, parent_id)
      if @@comments[parent_id].nil?
        @@comments[parent_id] = []
      end
      @@comments[parent_id] << comment
    end
  end

  class CommentProvider
    extend Forwardable
    def_delegators :@provider, :create, :delete, :update, :get_comments, :count

    attr_accessor :provider

    @@provider_class = StubCommentProvider

    def initialize(forum_id, thread_id, test_mode = false)
      @provider = @@provider_class.new(forum_id, thread_id, test_mode: test_mode)
    end

    def self.set_provider_class(provider_class)
      @@provider_class = provider_class
    end

  end

end
