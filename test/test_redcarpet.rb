require File.dirname(__FILE__) + '/helper'

class TestRedcarpet < Test::Unit::TestCase
  context "redcarpet" do
    setup do
      config = {
	    ## MANUALLY PATCHED FROM https://github.com/mojombo/jekyll/pull/450/
        'redcarpet' => {
          'extensions' => ['strikethrough', 'smart'],
          'render_options' => ['filter_html']
        },
		## END MANUAL PATCH
        'markdown' => 'redcarpet'
      }
      @markdown = MarkdownConverter.new config
    end
    
    should "pass redcarpet options" do
      assert_equal "<h1>Some Header</h1>", @markdown.convert('# Some Header #').strip
    end
    
    ## MANUALLY PATCHED FROM https://github.com/mojombo/jekyll/pull/450/
	should "pass redcarpet SmartyPants option" do
	## END MANUAL PATCH
      assert_equal "<p>&ldquo;smart&rdquo;</p>", @markdown.convert('"smart"').strip
    end
	
    ## MANUALLY PATCHED FROM https://github.com/mojombo/jekyll/pull/450/
    should "pass redcarpet extensions" do
      assert_equal "<p><del>deleted</del></p>", @markdown.convert('~~deleted~~').strip
    end

    should "pass redcarpet render options" do
      assert_equal "<p><strong>bad code not here</strong>: i am bad</p>", @markdown.convert('**bad code not here**: <script>i am bad</script>').strip
    end
	## END MANUAL PATCH
	
  end
end
