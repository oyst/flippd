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
      CommentSystem::MockCommentProvider.clear_comments
      use_comment_provider(CommentSystem::MockCommentProvider)
    end

    it "tells the user there are no comments" do
      within "#comments" do
        expect(page).to have_content "No comments yet"
      end
    end
  end

  context "with comments" do
    before do
      CommentSystem::MockCommentProvider.clear_comments
      CommentSystem::MockCommentProvider.generate_replies(count: 1)
      use_comment_provider(CommentSystem::MockCommentProvider)
    end

    it "does not tell the user there are no comments" do
      within "#comments" do
        expect(page).to_not have_content "No comments yet"
      end
    end

    it "contains the right info" do
      within "#comments" do
        expect(page).to have_content "User"
        expect(page).to have_content "19/02/15"
        expect(page).to have_content "message_0"
        expect(page).to have_link "Reply"
      end
    end

    context "at max depth" do
      before do
        CommentSystem::MockCommentProvider.clear_comments
        CommentSystem::MockCommentProvider.generate_nested_replies(depth: CommentSystem::MAX_REPLY_DEPTH)
        use_comment_provider(CommentSystem::MockCommentProvider)
      end

      it "contains the first comment" do
        within "#comments" do
          expect(page).to have_content "message_0"
        end
      end

      it "contains the 2nd comment" do
        within "#comments" do
          expect(page).to have_content "message_1"
        end
      end

      it "contains the last comment" do
        within "#comments" do
          expect(page).to have_content "message_#{CommentSystem::MAX_REPLY_DEPTH - 1}"
        end
      end

      it "does not contain the deeper comments link" do
        within "#comments" do
          expect(page).to_not have_link "Show deeper replies"
        end
      end
    end

    context "past max depth" do
      before do
        CommentSystem::MockCommentProvider.clear_comments
        CommentSystem::MockCommentProvider.generate_nested_replies(depth: CommentSystem::MAX_REPLY_DEPTH + 1)
        use_comment_provider(CommentSystem::MockCommentProvider)
      end

      it "contains the first comment" do
        within "#comments" do
          expect(page).to have_content "message_0"
        end
      end

      it "contains the 2nd comment" do
        within "#comments" do
          expect(page).to have_content "message_1"
        end
      end

      it "contains the second to last comment" do
        within "#comments" do
          expect(page).to have_content "message_#{CommentSystem::MAX_REPLY_DEPTH - 1}"
        end
      end

      it "does no contain the last comment" do
        within "#comments" do
          expect(page).to_not have_content "message_#{CommentSystem::MAX_REPLY_DEPTH}"
        end
      end

      it "contains the deeper comments link" do
        within "#comments" do
          expect(page).to have_link "Show deeper replies"
        end
      end
    end

    context "at max reply limit" do
      before do
        CommentSystem::MockCommentProvider.clear_comments
        CommentSystem::MockCommentProvider.generate_replies(count: CommentSystem::MAX_REPLY_COUNT)
        use_comment_provider(CommentSystem::MockCommentProvider)
      end

      it "contains the first comment" do
        within "#comments" do
          expect(page).to have_content "message_0"
        end
      end

      it "contains the 2nd comment" do
        within "#comments" do
          expect(page).to have_content "message_1"
        end
      end

      it "contains the last comment" do
        within "#comments" do
          expect(page).to have_content "message_#{CommentSystem::MAX_REPLY_COUNT - 1}"
        end
      end

      it "does not contain the show more comments link" do
        within "#comments" do
          expect(page).to_not have_link "Show more comments"
        end
      end
    end

    context "past max reply limit" do
      before do
        CommentSystem::MockCommentProvider.clear_comments
        CommentSystem::MockCommentProvider.generate_replies(count: CommentSystem::MAX_REPLY_COUNT + 1)
        use_comment_provider(CommentSystem::MockCommentProvider)
      end

      it "contains the first comment" do
        within "#comments" do
          expect(page).to have_content "message_0"
        end
      end

      it "contains the 2nd comment" do
        within "#comments" do
          expect(page).to have_content "message_1"
        end
      end

      it "contains the second to last comment" do
        within "#comments" do
          expect(page).to have_content "message_#{CommentSystem::MAX_REPLY_COUNT - 1}"
        end
      end

      it "does not contain the last comment" do
        within "#comments" do
          expect(page).to_not have_content "message_#{CommentSystem::MAX_REPLY_COUNT}"
        end
      end

      it "contains the show more comments link" do
        within "#comments" do
          expect(page).to have_link "Show more comments"
        end
      end
    end
  end

end
