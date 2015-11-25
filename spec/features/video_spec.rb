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
      CommentSystem::StubCommentProvider.show_comments = false
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
      CommentSystem::StubCommentProvider.show_comments = true
      use_comment_provider(CommentSystem::StubCommentProvider)
    end

    it "does not tell the user there are no comments" do
      within "#comments" do
        expect(page).to_not have_content "No comments yet"
      end
    end

    it "contains correct information in first comment" do
      within first("#comments .comment-container") do
        expect(page).to have_content "User1"
        expect(page).to have_content "19/02/95"
        expect(page).to have_content "Hello world!"
        expect(page).to have_link "Reply"
      end
    end
  end

end
