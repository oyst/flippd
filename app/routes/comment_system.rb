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
    def initialize(forum_id, thread_id, test_mode = false)
        user1 = User.new(1, "User1", "user1@mail.com")
        user2 = User.new(2, "User2", "user2@mail.com")
        user3 = User.new(3, "User3", "user3@mail.com")
        user4 = User.new(4, "User4", "user4@mail.com")

        @comments = {nil => [], 1 => [], 3 => [], 5 => []}
        @comments[nil] << Comment.new(1, "Hello world!", user1, 2, "19/02/95")
        @comments[nil] << Comment.new(2, "Test comment", user2, 0, "14/06/15")
        @comments[1] << Comment.new(3, "foo", user3, 1, "23/10/93")
        @comments[1] << Comment.new(4, "bar", user3, 0, "24/10/15")
        @comments[3] << Comment.new(5, "baz", user1, 0, "12/02/16")
        @comments[nil] << Comment.new(5, "Parent", user4, 1, "15/04/13")
        @comments[5] << Comment.new(6, "Child", user2, 0, "11/05/13")
    end

    def create(user_id, message, reply_id: nil)
    end

    def delete(user_id, comment_id)
    end

    def update(user_id, comment_id, message)
    end

    def get_comments(start: 0, max: 100, order: nil, parent_id: nil)
      if @comments[parent_id].nil?
        return []
      end
      return @comments[parent_id]
    end

    def count(parent_id: nil)
      if @comments[parent_id].nil?
        return 0
      end
      return @comments[parent_id].count
    end
  end

  class MockCommentProvider
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
