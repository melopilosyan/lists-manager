# @cjsx React.DOM

@ShowOrderModal = React.createClass
  getInitialState: ->
    meals: @props.order.meals

  row: (dt, dd) ->
    [ <dt>{ dt }:</dt>
      <dd>{ dd }</dd> ]

  mealsTable: () ->
    <table className='table table-striped' >
      <thead>
        <tr>
          <th>Name</th>
          <th>Added by</th>
          <th>Added on</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
          { @state.meals.map (meal) =>
              <tr key={ 'meal-' + meal.id } >
                <td>{ meal.name }</td>
                <td>{ meal.creator.name }</td>
                <td>{ meal.addedOn }</td>
                <td>{ @showActionsFor(meal) }</td>
              </tr> }
      </tbody>
    </table>

  showActionsFor: (meal) ->
    if MO.Statuses.isOrdered(@props.order) && meal.allowActions
      actionIconsFor meal, @updateMealDelete, @updateMealEdit

  updateMealDelete: (id) ->
    @updateMeals @state.meals.filter (m) -> m.id != id

  updateMealEdit: (id, newValue) ->
    @updateMeals @state.meals.map (m) ->
      if m.id == id
        meal = $.extend(true, {}, m)
        meal.name = newValue
        meal
      else
        m

  addMeal: (meal) ->
    @updateMeals [meal].concat @state.meals

  updateMeals: (meals) ->
    @setState meals: meals
    order = $.extend true, {}, @props.order
    order.meals = meals
    @props.updateOrders order

  
  render: ->
    order = @props.order
    addMeal = MO.Statuses.isOrdered(order) && @state.meals.filter((meal) -> meal.allowActions).length is 0

    <Modal id='show-order' title='Order details' >
      <dl className='dl-horizontal' >
        {[
          @row('Made against', order.name)
          @row('Made by', order.creator.name)
          @row('Made on', order.madeOn)
          <br key='br' />
          @row('Status', order.status)
        ]}
      </dl>
      <h2>
        <small>Meals</small>
        <div className='pull-right' >
          { addMeal && <AddMeal orderId={ @props.order.id } addMeal={ @addMeal } /> }
        </div>
      </h2>
      { @mealsTable() }
    </Modal>


# ShowOrderModal helper function
@showOrderDetails = (order, user, updateOrders) ->
  ReactDOM.render <ShowOrderModal order={ order } updateOrders={ updateOrders } />, MO.modalContainer

