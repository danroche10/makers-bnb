def add_test_spaces
  Space.create('space1', 'semi comfortable', 10000)
  Space.create('space2', 'very comfortable', 10)
  Space.create('space3', 'uncomfortable', 100000)
end