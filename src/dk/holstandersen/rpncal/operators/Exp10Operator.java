package dk.holstandersen.rpncal.operators;

import dk.holstandersen.rpncal.RPNOperationException;

public class Exp10Operator implements UnaryOperator {

	@Override
	public Double calculate(Double arg)
			throws RPNOperationException {
		return Math.pow(10, arg);
	}

}
