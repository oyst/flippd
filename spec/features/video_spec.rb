feature "A video page" do
  before(:each) do ||
     visit('/videos/2')
  end

  it "contains the video's title" do
    within('#main h1') do
      expect(page).to have_content 'Ruby Gems'
    end
  end

  it "contains the video's description" do
    expect(page).to have_content 'Introduces RubyGems and Bundler for managing Ruby dependencies.'
  end

  it "contains navigation links" do
    expect(page).to have_link 'Ruby', href: "/videos/1"
    expect(page).to have_link 'Planning vs. reacting', href: "/videos/3"
  end

  it "contains links to additional material" do
    expect(page).to have_link 'Ruby Gems Documentation', href: 'http://guides.rubygems.org'
    expect(page).to have_link 'Bundler', href: 'http://bundler.io'
    expect(page).to have_link 'Ruby Toolbox', href: 'https://www.ruby-toolbox.com'
  end

  context "for the first video" do
    it "contains a forward navigation link" do
      visit('/videos/1')
      expect(page).to have_link 'Ruby Gems', href: "/videos/2"
    end
  end

  context "for the last video" do
    it "contains a backward navigation link" do
      visit('/videos/31')
      expect(page).to have_link 'Middleware', href: "/videos/30"
    end
  end

  it "contains a comments section" do
    within "#comments" do
      expect(page).to have_content "Comments"
    end
  end

  context "with no comments" do
    before do
      CommentSystem::StubCommentProvider.clear_comments
      use_comment_provider(CommentSystem::StubCommentProvider)
    end

    it "tells the user there are no comments" do
      within "#comments" do
        expect(page).to have_content "No comments yet"
      end
    end
  end

  context "with comments" do
    before do

      user = CommentSystem::User.new(1, "User", "user1@mail.com")
      c1 = CommentSystem::Comment.new(1, "foo", user, 1, "19/02/15")
      c2 = CommentSystem::Comment.new(2, "bar", user, 1, "23/10/15")
      c3 = CommentSystem::Comment.new(3, "baz", user, 0, "25/11/15")

      CommentSystem::StubCommentProvider.clear_comments
      CommentSystem::StubCommentProvider.add_comment(c1, nil)
      CommentSystem::StubCommentProvider.add_comment(c2, 1)
      CommentSystem::StubCommentProvider.add_comment(c3, 2)

      use_comment_provider(CommentSystem::StubCommentProvider)
    end

    it "does not tell the user there are no comments" do
      within "#comments" do
        expect(page).to_not have_content "No comments yet"
      end
    end

    it "contains correct information in first comment" do
      within "#comments" do
        expect(page).to have_content "User"
        expect(page).to have_content "19/02/15"
        expect(page).to have_content "foo"
        expect(page).to have_link "Reply"
      end
    end

    it "contains a nested comment" do
      within "#comments" do
        expect(page).to have_content "User"
        expect(page).to have_content "23/10/15"
        expect(page).to have_content "bar"
        expect(page).to have_link "Reply"
      end
    end

    it "contains a double nested comment" do
      within "#comments" do
        expect(page).to have_content "User"
        expect(page).to have_content "25/11/15"
        expect(page).to have_content "baz"
        expect(page).to have_link "Reply"
      end
    end

  end

end
