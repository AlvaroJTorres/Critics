module CriticsHelper
  def format_date(from)
    "Sent #{distance_of_time_in_words(from, Time.current)} ago"
  end

  def critic_approve_link(criticable, critic)
    case criticable.class.to_s
    when 'Game'
      link_to 'Approve', game_critic_path(criticable, critic, approved: 1),
              method: :patch,
              class: 'content--sm'
    when 'Company'
      link_to 'Approve', company_critic_path(criticable, critic, approved: 1),
              method: :patch,
              class: 'content--sm'
    end
  end

  def critic_trash_link(criticable, critic)
    case criticable.class.to_s
    when 'Game'
      link_to game_critic_path(criticable, critic), method: :delete do
        image_tag '/images/icons/trash.svg'
      end
    when 'Company'
      link_to company_critic_path(criticable, critic), method: :delete do
        image_tag '/images/icons/trash.svg'
      end
    end
  end
end
