import hashlib
import time
import json


def check_if_armstrong(val):
    digits = str(val)
    power = len(digits)
    total = sum(int(d) ** power for d in digits)
    return total == val


class BlockNode:
    def __init__(self, idx, payload, prev_hash):
        self.idx = idx
        self.timestamp = time.time()
        self.payload = payload
        self.prev_hash = prev_hash
        self.block_hash = self.generate_hash()

    def generate_hash(self):
        block_dict = {
            "idx": self.idx,
            "payload": self.payload,
            "prev_hash": self.prev_hash,
            "time": self.timestamp
        }
        encoded_block = json.dumps(block_dict, sort_keys=True).encode()
        return hashlib.sha256(encoded_block).hexdigest()


class ArmstrongChain:
    def __init__(self):
        self.chain = [BlockNode(0, "Genesis", "0")]

    def insert_block(self, number):
        is_arm = check_if_armstrong(number)
        last_block = self.chain[-1]
        new_node = BlockNode(len(self.chain), {"number": number, "is_armstrong": is_arm}, last_block.block_hash)
        self.chain.append(new_node)
        print(f"Block {new_node.idx} added! Number {number} Armstrong status: {is_arm}")

    def validate_chain(self):
        for i in range(1, len(self.chain)):
            current = self.chain[i]
            previous = self.chain[i - 1]
            if current.block_hash != current.generate_hash() or current.prev_hash != previous.block_hash:
                return False
        return True


if __name__ == "__main__":
    blockchain = ArmstrongChain()
    blockchain.insert_block(153)  # Valid Armstrong
    blockchain.insert_block(22)   # Not Armstrong
    print("Is the blockchain valid?", blockchain.validate_chain())
