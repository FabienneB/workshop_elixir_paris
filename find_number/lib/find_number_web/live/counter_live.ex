defmodule FindNumberWeb.CounterLive do
  use Phoenix.LiveView
  require IEx

  def mount(_, socket) do
    # :count_value is an atom, as a symbol in ruby
    {:ok, socket
             |> assign(:count_value, 0)
             |> assign(:count_try, 0)
             |> assign(:max_tries, 10)
             |> assign(:random_number, :rand.uniform(10))
    }
 end

  def handle_event("increment", _, socket) do
    {:noreply, socket 
                |> assign(:count_value, socket.assigns.count_value + 1)
                |> assign(:count_try, socket.assigns.count_try + 1)
    }
  end

  def handle_event("decrement", _, socket) do
    {:noreply, socket 
                |> assign(:count_value, socket.assigns.count_value - 1)
                |> assign(:count_try, socket.assigns.count_try + 1)
    }
  end

  def handle_event("reset", _, socket) do
    {:noreply, socket
      |> assign(:count_value, 0)
      |> assign(:count_try, 0)
    }
  end

  def render(assigns) do
    # @ is an assign we can isplay it in the view
    ~L"""
    <%= if @count_try < 10 do %>
      <%= if @count_value == @random_number do %>
        <h2>Tu as gagné</h2>
      <%= else %>
       <h2>Essai encore, tu as <%=@max_tries - @count_try %> essais restants</h2>
     <% end %>
      <%= else %>
      <h2>Tu as perdu</h2>
    <% end %>
    
    <div>
      Your guess:
    </div>

    <h1><%=@count_value %></h1>
    <button phx-click="increment">increment</button>
    <button phx-click="decrement">decrement</button>
    <h3><%=@max_tries - @count_try %> essais restants</h3>

    <button phx-click="reset">réinitialiser</button>

    """
  end
end
