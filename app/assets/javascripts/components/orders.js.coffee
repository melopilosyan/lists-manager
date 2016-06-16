# @cjsx React.DOM

@Orders = React.createClass
  head: ->
    if @props.type == 'active'
      <thead>
        <tr>
          <th width='40' className='text-center'>#</th>
          <th>Restaurant Name</th>
          <th>Creator</th>
          <th>Made on</th>
          <th>Status</th>
          <th></th>
        </tr>
      </thead>

  render: ->
    <table className='table table-hover'>
      { @head() }
      <tbody>
        { @props.orders.map (order, index) =>
            <Order
              index={ index + 1 }
              order={ order }
              authenticated={ @props.authenticated }
              allowEdit={ @props.allowEdit }
              updateOrders={ @props.updateOrders }
              key={ 'order-' + order.id } /> }
      </tbody>
    </table>

