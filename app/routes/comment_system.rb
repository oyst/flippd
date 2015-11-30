module CommentSystem

  class User
    attr_accessor :id, :name, :email

    def initialize(id:, name:, email:)
      @id = id
      @name = name
      @email = email
    end
  end

  class Comment
    attr_accessor :id, :message, :user, :reply_count, :creation_date

    def initialize(id:, message:, user:, reply_count:, creation_date:)
      @id = id
      @message = message
      @user = user
      @reply_count = reply_count
      @creation_date = creation_date
    end
  end

  class StubCommentProvider
    def initialize(forum_id, thread_id, test_mode = false)
        user1 = User.new(id:1, name:"User1", email:"user1@mail.com")
        user2 = User.new(id:2, name:"User2", email:"user2@mail.com")
        user3 = User.new(id:3, name:"User3", email:"user3@mail.com")
        user4 = User.new(id:4, name:"User4", email:"user4@mail.com")

        @comments = {nil => [], 1 => [], 3 => [], 5 => []}
        @comments[nil] << Comment.new(id:1, message:"Hello world!", user:user1, reply_count:2, creation_date:"19/02/95")
        @comments[nil] << Comment.new(id:2, message:"Test comment", user:user2, reply_count:0, creation_date:"14/06/15")
        @comments[1] << Comment.new(id:3, message:"foo", user:user3, reply_count:1, creation_date:"23/10/93")
        @comments[1] << Comment.new(id:4, message:"bar", user:user3, reply_count:0, creation_date:"24/10/15")
        @comments[3] << Comment.new(id:5, message:"baz", user:user1, reply_count:0, creation_date:"12/02/16")
        @comments[nil] << Comment.new(id:5, message:"Parent", user:user4, reply_count:1, creation_date:"15/04/13")
        @comments[5] << Comment.new(id:6, message:"Child", user:user2, reply_count:0, creation_date:"11/05/13")
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
      @@comments[parent_id][start, max]
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

    def self.generate_nested_replies(depth:)
      self.clear_comments

      user = User.new(id: 1,
                      name: "User",
                      email: "user@mail.com")
      for d in 0..depth-1
        comment = Comment.new(id: d,
                              message: "message_#{d}",
                              user: user,
                              reply_count: (d == depth-1) ? 0 : 1,
                              creation_date: "19/02/15")
        self.add_comment(comment, (d == 0) ? nil : d-1)
      end
    end

    def self.generate_replies(count:)
      self.clear_comments

      user = User.new(id: 1,
                      name: "User",
                      email: "user@mail.com")
      for c in 0..count-1
        comment = Comment.new(id: c,
                              message: "message_#{c}",
                              user: user,
                              reply_count: 0,
                              creation_date: "19/02/15")
        self.add_comment(comment, nil)
      end
    end
  end


  MAX_REPLY_DEPTH = 10
  MAX_REPLY_COUNT = 20
  @provider = MockCommentProvider

  def self.get_provider(forum_id, thread_id, test_mode: false)
    return @provider.new(forum_id, thread_id, test_mode)
  end

  def self.set_provider(c)
    @provider = c
  end

end
