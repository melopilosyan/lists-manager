# @cjsx React.DOM

@Order = React.createClass
  render: ->
    order = @props.order

    <tr>
      <th>{ order.id }</th>
      <td>{ @props.user.authenticated && linkFor(order.name, showOrderDetails.bind(order)) || order.name }</td>
      <td>{ order.status }</td>
      <td>{ order.creator.name }</td>
      <td>{ order.madeOn }</td>
      <td></td>
    </tr>

