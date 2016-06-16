# @cjsx React.DOM

@Order = React.createClass
  updateOrder: (id, newValue, statusChanged) ->
    order = $.extend true, {}, @props.order
    order[statusChanged && 'status' || 'name'] = newValue
    @props.updateOrders order, false, statusChanged

  render: ->
    order = @props.order
    allowChangeStatus = @props.authenticated && order.allowActions && order.status != MO.Statuses.Finalized

    <tr>
      <th className='text-center'>{ @props.index }</th>
      <td>{ linkFor(order.name, showOrderDetails.bind(null, order, @props.user, @props.updateOrders)) }</td>
      <td>{ order.creator.name }</td>
      <td>{ order.madeOn }</td>
      <td>{ if allowChangeStatus then changeStatusModalLink(order, @updateOrder) else order.status }</td>
      <td width="55" className='text-center' >
        { @props.authenticated && actionIconsFor(
            @props.order
            @props.updateOrders
            @props.allowEdit && MO.Statuses.isOrdered(order) && @updateOrder) }
      </td>
    </tr>

