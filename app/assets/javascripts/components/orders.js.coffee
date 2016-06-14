# @cjsx React.DOM

@Orders = React.createClass
  actionRow: ->
    <div className='row'>
      <div className='col-md-12'>
        <div className=' pull-right'>
          { makeOrderButton(@props.onMakeOrder) }
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
                <th>Status</th>
                <th>Creator</th>
                <th>Made on</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              { @props.orders.map (order) =>
                  <Order user={ @props.user } order={ order } key={ 'order-' + order.id } /> }
            </tbody>
          </table>
        </div>
      </div>
    </div>

