module UsersHelper
  def gravatar_for(user, opt = {})
    base_gravatar_url = "https://secure.gravatar.com/avatar/"

    gravatar_id = Digest::MD5.hexdigest( user.email.downcase )
    gravatar_url = "#{base_gravatar_url}#{gravatar_id}#{"?s=#{opt[:size]}" if !opt[:size].nil?}"

    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
