# @cjsx React.DOM

@ShowOrderModal = React.createClass
  row: (dt, dd) ->
    [ <dt>{ dt }:</dt>
      <dd>{ dd }</dd> ]

  mealRow: (meals) ->
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
          { meals.map (meal) =>
             [ <td>{ meal.name }</td>
               <td>{ meal.creator.name }</td>
               <td>{ meal.addedOn }</td> ] }
        </tr>
      </tbody>
    </table>

  render: ->
    order = @props.order

    <Modal id='show' title='Order details'>
      <dl className='dl-horizontal' >
        {[
          @row('Made against', order.name)
          @row('Made by', order.creator.name)
          @row('Status', order.status)
          @row('Made on', order.madeOn)
        ]}
      </dl>
      <h1><small>Meals</small></h1>
      { @mealRow order.meals }
    </Modal>


# ShowOrderModal helper function
@showOrderDetails = () ->
  ReactDOM.render <ShowOrderModal order={ @ } />, document.getElementById('show-order-modal-container')

