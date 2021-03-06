object @post

attributes :id, :speed, :caption, :images

child (:user) {attributes :username, :id, :avatar}

node(:liked) {|post| current_user.like?(post)}

node(:get_likes_count) {|post| post.get_likes_count}

node(:get_comment_count) {|post| post.get_comment_count}

node(:posted) {|post| post.created_at.to_i}