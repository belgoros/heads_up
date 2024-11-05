defmodule HeadsUpWeb.Components.CustomComponents do
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
      <%= @status %>
    </div>
    """
  end
end
