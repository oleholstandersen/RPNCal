package dk.holstandersen.rpncal.operators;

import dk.holstandersen.rpncal.RPNOperationException;


public class SubtractionOperator  implements BinaryOperator {
	@Override
	public Double calculate(Double arg1, Double arg2) throws RPNOperationException {
		return arg1-arg2;
	}

}
