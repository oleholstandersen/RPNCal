package dk.holstandersen.rpncal.operators;

import dk.holstandersen.rpncal.RPNOperationException;

public class SqrOperator implements UnaryOperator {

	@Override
	public Double calculate(Double arg) throws RPNOperationException {
		return Math.pow(arg, 2);
	}

}
