TTumblrPostsFetcher
===================

Fetching posts from Tumblr using Tumblr Apis - ObjectiveC project

1.Using Tumblr apis require an OAuth token. Please follow the below steps to get an OAuth token.

    - Get yourself an OAuth token from http://www.tumblr.com/oauth/apps
    - Click Register Application, fill the form and click register to generate an access token.
    - Make a note of the generated Access Token. It will be something similar to “abS8jX9828kc7hkx2Rm4T3My9eozbDoQgPPPCuFLXKIiWNYerL”.

2. Clone and setup XCode project

    - Clone or download the Xcode project. 
    - Launch and build the project. It will show few errors. That is because we need to setup the OAuth token we previously generated.
    - Open URLConstants.h file and replace the text "your api key" with the OAuth token you previously generated.
    - Replace the text "blog name" with the name of the blog where you want to fetch the posts.
    - Remove the #error directive from the lines above the api key and blog name directives.

3. Build and Run.

4. You should now be able to see the list of all the posts.

5. You could also build a detail screen with the posts fetched.

For more information on Tumblr Apis, visit - http://www.tumblr.com/docs/en/api/v2