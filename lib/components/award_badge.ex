# credo:disable-for-this-file Credo.Check.Readability.Specs

defmodule UneebeeWeb.Components.AwardBadge do
  @moduledoc """
  Award badges.

  Badges displayed when a user earns a medal or an award.
  """
  use Phoenix.Component

  import UneebeeWeb.Components.Icon
  import UneebeeWeb.Gettext

  alias Uneebee.Gamification.Medal

  @doc """
  Renders a badge for learning days.

  ## Examples

      <.learning_days_badge days={@learning_days} />
  """
  attr :days, :integer, required: true

  def learning_days_badge(assigns) do
    ~H"""
    <.award_badge
      id="learning-days-badge"
      icon="tabler-calendar-heart"
      value={@days}
      label={dngettext("gamification", "Learning day", "Learning days", @days)}
    />
    """
  end

  @doc """
  Renders a badge for a medal.
  """
  attr :medal, Medal, required: true

  def medal_badge(assigns) do
    ~H"""
    <.award_badge
      id="medal-badge"
      color={medal_color(@medal.medal)}
      icon="tabler-medal"
      value={@medal.label}
      label={@medal.description}
    />
    """
  end

  defp medal_color(:gold), do: :warning
  defp medal_color(:silver), do: :gray
  defp medal_color(:bronze), do: :bronze

  attr :id, :string, required: true
  attr :color, :atom, default: :primary, values: [:primary, :warning, :alert, :gray, :bronze]
  attr :icon, :string, required: true
  attr :value, :string, required: true
  attr :label, :string, required: true

  defp award_badge(assigns) do
    ~H"""
    <div
      id={@id}
      class={[
        "flex flex-1 flex-col items-center gap-1 rounded-2xl p-4 text-center",
        @color == :primary && "bg-primary-light2x text-primary-dark2x",
        @color == :warning && "bg-warning-light2x text-warning-dark2x",
        @color == :alert && "bg-alert-light2x text-alert-dark2x",
        @color == :gray && "bg-gray-light2x text-gray-dark2x",
        @color == :bronze && "bg-bronze-light2x text-bronze-dark2x"
      ]}
    >
      <.icon name={@icon} />
      <span class="font-black"><%= @value %></span>
      <span class="text-xs font-light"><%= @label %></span>
    </div>
    """
  end
end