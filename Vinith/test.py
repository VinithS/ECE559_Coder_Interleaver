import random
import binascii
import time


def interleaver(input_num, flag_6144):
    f1 = 263 if flag_6144 == 1 else 17
    f2 = 480 if flag_6144 == 1 else 66
    k = 6144 if flag_6144 == 1 else 1056
    input_inv = input_num[::-1]

    # print 'f1, f2, k', f1, f2, k

    output = [''] * k
    for i in range(k):
        pi_i = (f1 * i + f2 * i ** 2) % k
        output[i] = input_inv[pi_i]
    return ''.join(output)[::-1]


def create_val(last_number):
    out_str = ''
    for x in range(6143):
        out_str += str(random.randint(0, 1))
    out_str += last_number
    return out_str


def print_mif(input):
    # print_in = list(input)
    for x in range(768):
        print '%s  :   %s;' % (x, input[x * 8:x * 8 + 8])


def get_bin(hex_num):
    hex2bin_map = {
        "0": "0000",
        "1": "0001",
        "2": "0010",
        "3": "0011",
        "4": "0100",
        "5": "0101",
        "6": "0110",
        "7": "0111",
        "8": "1000",
        "9": "1001",
        "A": "1010",
        "B": "1011",
        "C": "1100",
        "D": "1101",
        "E": "1110",
        "F": "1111",
    }
    return "".join(hex2bin_map[i] for i in hex_num)


def get_hex_from_bin(bin_num):
    hex2bin_map = {
        "0": "0000",
        "1": "0001",
        "2": "0010",
        "3": "0011",
        "4": "0100",
        "5": "0101",
        "6": "0110",
        "7": "0111",
        "8": "1000",
        "9": "1001",
        "A": "1010",
        "B": "1011",
        "C": "1100",
        "D": "1101",
        "E": "1110",
        "F": "1111",
    }
    bin2hex_map = {v: k for k, v in hex2bin_map.iteritems()}
    hex_ret = ''
    for i in range(0, len(bin_num), 4):
        hex_ret += bin2hex_map[bin_num[i:i+4]]
    return hex_ret


if __name__ == '__main__':
    # # input_val = create_val('0')
    # is_6144 = 1
    # # input_val = input_val if is_6144 == 1 else input_val[-1056:]
    # input_val = ['1', '1', '0', '1', '1', '0'] * 1024
    # input_val[8:31] = '000000000000000100000010'
    # input_val = ''.join(input_val)
    # print 'input value', 'of size', len(input_val)
    # print input_val
    # output_val = interleaver(input_val, is_6144)
    # print 'output value'
    # print output_val
    # print 'top 8', output_val[:8]
    # print 'bot 8', output_val[-8:]
    #
    # # print the mif file
    # print_mif(input_val)

    test_1_hex = ''
    for _ in range(129):
        test_1_hex += 'C9'
    test_1_hex += '2A1438'

    test_2_hex = ''
    for _ in range(59):
        test_2_hex += '00'
    for _ in range(70):
        test_2_hex += 'C9'
    test_2_hex += '153424'

    test_3_hex = ''
    for _ in range(765):
        test_3_hex += 'C9'
    test_3_hex += '553355'

    test_4_hex = ''
    for _ in range(94):
        test_4_hex += '00'
    for _ in range(671):
        test_4_hex += 'C9'
    test_4_hex += '2BEF40'

    test_input_hex = [test_1_hex, test_2_hex, test_3_hex, test_4_hex]
    test_input_bin = []
    for hex_num in test_input_hex:
        test_input_bin.append(get_bin(hex_num))
    test_out = []
    for in_bin in test_input_bin:
        le = 1 if len(in_bin) == 6144 else 0
        test_out.append(interleaver(in_bin, le))

    for out in test_out:
        print get_hex_from_bin(out)
