# @cjsx React.DOM

@Orders = React.createClass
  render: ->
    <div className='row'>
      <table className='table table-striped'>
        <thead>
          <tr>
            <th>Restaurant Name</th>
            <th>Creator</th>
            <th>Status</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>O1</td>
            <td>C1</td>
            <td>S1</td>
            <td></td>
          </tr>
          <tr>
            <td>O2</td>
            <td>C2</td>
            <td>S2</td>
            <td></td>
          </tr>
          <tr>
            <td>O3</td>
            <td>C3</td>
            <td>S3</td>
            <td></td>
          </tr>
        </tbody>
      </table>
    </div>
