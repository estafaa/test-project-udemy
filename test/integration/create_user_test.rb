require 'test_helper'

class CreateUserTest < ActionDispatch::IntegrationTest
    
    def setup
    
        
    end
    
    
    test "create new user" do
        get signup_path
        assert_template 'users/new'
        assert_difference 'User.count', 1 do
           post_via_redirect users_path, user: { username: "newguy", email: "email@ail.com", password: "strongable1" }
        end
        assert_template 'users/show'
        assert_match "newguy", response.body
    end
    
    
     test "new user name too short" do
        get signup_path
        assert_template 'users/new'
        assert_no_difference 'User.count' do
           post_via_redirect users_path, user: { username: "ne", email: "email@ail.com", password: "strongable1" }
        end
        assert_template 'users/new'
    end
  
   test "create new article" do
        @user = User.create(username: "Anton", email: "aaa@aaa.aa", password: "password", admin: true )
        sign_in_as(@user, "password")
        get new_article_path
        assert_template 'articles/new'
        assert_difference 'Article.count', 1 do
           post_via_redirect articles_path, article: { title: "tittititlele", description: "titdescriptions dfknf dfkdmvkmdc le" }
        end
        assert_template 'articles/show'
        assert_match "tittititlele", response.body
    end
    
end