module QuestionsHelper
  def render_with_hashtag(text)
    reg = /#[\p{L}0-9_]{1,30}/
    text.gsub(reg) { |tag| link_to tag, tag_path(tag.delete('#'))}.html_safe
  end
end
