package vpc

import future.keywords.in

# simple VPAS rule
# we get input as the amount specified in the transaction
# we should return back updated balance if transaction is successful otherwise simply return false

default vpas = false

vpas = response {
	mainRule
	response := {
        "balance": Balance
    }
}

mainRule {
	input.transaction.amount in input.rule.allowedTransactions
}

Balance[resp] {
    mainRule == true
	newbalance:= input.transaction.balance-input.transaction.amount
    resp := newbalance
}
