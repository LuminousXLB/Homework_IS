from isCoprime import isCoprime
# from Euler import Euler
from ModularArith import MMultiply
from Power import power
from Crypto.Util.number import getPrime


def invert(e, m):
    print('invert({},{})'.format(e, m))
    if isCoprime(e, m):
        d = m//e
        while MMultiply(d, e, m) != 1:
            d += 1
        return d
    else:
        return None


def generate():
    p = getPrime(14)
    q = getPrime(14)
    n = p*q
    e = getPrime(8)
    d = invert(e, (p-1)*(q-1))
    return (n, e), (n, d)


def encrypt(pubkey, msg, enc):
    n, e = pubkey
    ba = bytearray(msg)


def main():
    f = open('msg.txt', 'rb')

    f.close()

    # print(e, d)

    # pubkey = RSA.construct((long(n), long(e)))
    # privatekey = RSA.construct((long(n), long(e), long(d), long(p), long(q)))
    # key = PKCS1_v1_5.new(pubkey)
    # enc = key.encrypt(msg).encode('base64')
    # key = PKCS1_v1_5.new(privatekey)
    # msg = key.decrypt(enc.decode('base64'), e)


if __name__ == '__main__':
    main()
