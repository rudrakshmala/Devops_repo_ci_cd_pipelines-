import hashlib
import time
import json


def is_anagram(str1, str2):
    format_str1 = sorted(str1.replace(" ", "").lower())
    format_str2 = sorted(str2.replace(" ", "").lower())
    return format_str1 == format_str2


class AnagramNode:
    def __init__(self, s1, s2, prev="0"):
        self.time_stamp = time.time()
        self.s1 = s1
        self.s2 = s2
        self.anagram_result = is_anagram(s1, s2)
        self.prev = prev
        self.hash = self.compute_hash()

    def compute_hash(self):
        data = json.dumps({
            "s1": self.s1,
            "s2": self.s2,
            "result": self.anagram_result,
            "time": self.time_stamp,
            "prev": self.prev
        }, sort_keys=True).encode()
        return hashlib.sha256(data).hexdigest()


if __name__ == "__main__":
    stmt1 = input("Enter first statement: ")
    stmt2 = input("Enter second statement: ")
    block = AnagramNode(stmt1, stmt2)
    print("\n--- Block Generated ---")
    print(f"Are Anagrams: {block.anagram_result}")
    print(f"Cryptographic Hash: {block.hash}")
