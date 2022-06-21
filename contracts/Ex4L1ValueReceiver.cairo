# ######## L1 Value Receiver

%lang starknet

# Imports

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1

# Hard-coded Value

const l1_evaluator_address = 732664983080715136788290267553922222853235868025 # 0x8055d587A447AE186d1589F7AAaF90CaCCc30179

# Storage Variable
# Not visible through the ABI by default, similar to "private" variables in Solidity.

@storage_var
func l1_assigned_var_storage() -> (assigned_var : felt):
end

# Getter

@view
func l1_assigned_var{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (assigned_var : felt):
    let (assigned_var) = l1_assigned_var_storage.read()
    return (assigned_var)
end

# L1 Handler

@l1_handler
func receive_l1_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    from_address : felt, rand_value : felt
):
    # Check L1 sender
    with_attr error_message("Message was not sent by the official L1 contract"):
        assert from_address = l1_evaluator_address
    end
    # Record value
    l1_assigned_var_storage.write(rand_value)
    return ()
end