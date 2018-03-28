from isCoprime import isCoprime
from Euler import Euler
from Power import power
from Crypto.Util.number import getPrime
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_v1_5


def invert(e, m):
    print('invert({},{})'.format(e, m))
    if isCoprime(e, m):
        return power(e, Euler(m)-1)
    else:
        return None


def main():
    msg = 'Mathematical Fundation of Information security + 20180327 + 516021910528'
    p = getPrime(14)
    q = getPrime(14)
    n = p*q
    d = None
    while d == None:
        e = getPrime(8)
        d = invert(e, (p-1)*(q-1))
        print(e, d)
    pubkey = RSA.construct((long(n), long(e)))
    privatekey = RSA.construct((long(n), long(e), long(d), long(p), long(q)))
    key = PKCS1_v1_5.new(pubkey)
    enc = key.encrypt(msg).encode('base64')
    key = PKCS1_v1_5.new(privatekey)
    msg = key.decrypt(enc.decode('base64'), e)


if __name__ == '__main__':
    main()
