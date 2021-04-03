import * as React from "react"


interface IProductDataProps {
  column: string;
  value: string;
}

interface IProductDataState {
}

class ProductData extends React.Component <IProductDataProps, IProductDataState> {
  render() {
    return (
      <React.Fragment>
        <div>
          <p className="text-gray-600"> {this.props.column} </p>
          <p className="text-gray-400"> {this.props.value} </p>
        </div>
      </React.Fragment>
    );
  }
}

export default ProductData
