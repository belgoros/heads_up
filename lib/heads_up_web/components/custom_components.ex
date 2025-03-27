defmodule HeadsUpWeb.CustomComponents do
  use HeadsUpWeb, :html

  attr :status, :atom, values: [:pending, :resolved, :canceled], default: :pending
  attr :class, :string, default: nil

  def badge(assigns) do
    ~H"""
    <div class={[
      "inline-block px-2 py-1 text-xs font-medium uppercase border rounded-md",
      @status == :resolved && "text-lime-600 border-lime-600",
      @status == :pending && "text-amber-600 border-amber-600",
      @status == :canceled && "text-gray-600 border-gray-600",
      @class
    ]}>
      {@status}
    </div>
    """
  end

  attr :admin, :boolean
  attr :class, :string, default: nil

  def admin_badge(assigns) do
    ~H"""
    <div class={[
      "inline-block px-2 py-1 text-xs font-medium uppercase border rounded-md",
      @admin == true && "text-lime-600 border-lime-600",
      @admin == false && "text-amber-600 border-amber-600",
      @class
    ]}>
      <.icon name="hero-shield-check" class="w-5 h-5" />
    </div>
    """
  end

  slot :inner_block, required: true
  slot :tagline

  def headline(assigns) do
    assigns = assign(assigns, :emoji, ~w(👍 🙌 👊) |> Enum.random())

    ~H"""
    <div class="headline">
      <h1>
        {render_slot(@inner_block)}
      </h1>
      <div class="tagline">
        {render_slot(@tagline, @emoji)}
      </div>
    </div>
    """
  end
end
