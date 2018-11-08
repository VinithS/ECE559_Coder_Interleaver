import random


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
        print '%s  :   %s;' % (x, input[x*8:x*8+8])


if __name__ == '__main__':
    # input_val = create_val('0')
    is_6144 = 1
    # input_val = input_val if is_6144 == 1 else input_val[-1056:]
    input_val = ['1', '1', '0', '1', '1', '0'] * 1024
    input_val[8:31] = '000000000000000100000010'
    input_val = ''.join(input_val)
    print 'input value', 'of size', len(input_val)
    print input_val
    output_val = interleaver(input_val, is_6144)
    print 'output value'
    print output_val
    print 'top 8', output_val[:8]
    print 'bot 8', output_val[-8:]

    # print the mif file
    print_mif(input_val)