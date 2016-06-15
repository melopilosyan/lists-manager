# @cjsx React.DOM

@Orders = React.createClass
  actionRow: ->
    btnsCls = 'btn btn-primary btn-xs'
    <div className='row'>
      <div className='col-md-12'>
        <div className=' pull-left'>
          { linkFor 'Refresh', btnsCls, @props.refresh }
        </div>
        <div className=' pull-right'>
          { makeOrderButton(@props.updateOrders, btnsCls) }
        </div>
      </div>
    </div>

  render: ->
    <div>
      { @props.user.authenticated && @actionRow() }
      <div className='row'>
        <div className='col-md-12'>
          <table className='table table-hover'>
            <thead>
              <tr>
                <th width="30">#</th>
                <th>Restaurant Name</th>
                <th>Creator</th>
                <th>Made on</th>
                <th>Status</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              { @props.orders.map (order) =>
                  <Order
                    user={ @props.user }
                    order={ order }
                    updateOrders={ @props.updateOrders }
                    key={ 'order-' + order.id } /> }
            </tbody>
          </table>
        </div>
      </div>
    </div>

