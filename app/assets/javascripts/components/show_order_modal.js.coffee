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
        </tr>
      </thead>
      <tbody>
        <tr>
          { @state.meals.map (meal) =>
             [ <td>{ meal.name }</td>
               <td>{ meal.creator.name }</td>
               <td>{ meal.addedOn }</td> ] }
        </tr>
      </tbody>
    </table>

  allowToAddMeal: ->
    @state.meals.filter((meal) => meal.creator.id is @props.user.id).length is 0

  updateMeals: (meals) ->
    @setState meals: meals
    
  render: ->
    order = @props.order

    <Modal id='show-order' title='Order details' >
      <dl className='dl-horizontal' >
        {[
          @row('Made against', order.name)
          @row('Made by', order.creator.name)
          @row('Status', order.status)
          @row('Made on', order.madeOn)
        ]}
      </dl>
      <h2>
        <small>Meals</small>
        <div className='pull-right' >
          { @allowToAddMeal() && <AddMeal
                                    orderId={ @props.order.id }
                                    updateOrders={ @props.updateOrders }
                                    updateMeals={ @updateMeals } /> }
        </div>
      </h2>
      { @mealsTable() }
    </Modal>


# ShowOrderModal helper function
@showOrderDetails = (order, user, updateOrders) ->
  ReactDOM.render <ShowOrderModal
                        order={ order }
                        user={ user }
                        updateOrders={ updateOrders } />
  , document.getElementById('show-order-modal-container')

