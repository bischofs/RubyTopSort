
##############################################
# Steve Bischoff                             #
# MAth 325                                   #
# Topological sort and matrix representation #
##############################################

require 'tsort'

#########################################
# This is the modified hash class       #
# for topological sort                  #
# sets an alias for the each key method #
#########################################

class Hash
  include TSort
  alias tsort_each_node each_key
  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end

def main

  row  = Array.new
  counter = 0

  File.open("oak.txt", "r").each_line do |line| #parse data

    if line.chomp != "E"
      row[counter] = line.chomp.split(',')
      counter += 1
    else     
      printMatrix(counter,row)
      totalCheck(counter,row)
      counter = 0
    end
  
  end

end

#############################
# PRints the matrix of the  #
# unsorted set              #
#############################

def printMatrix(counter,row)

  matrix = Array.new(counter, 0){Array.new(counter, 0)} # create matrix  

  for i in 0..matrix.length - 1  # populate matrix
    for j in 0..row[i].length - 1 
      if row[i][0] != "X"
        matrix[i][row[i][j].to_i] = 1
      end
    end
  end
  
  puts "The matrix representation of the poset is:"

  for i in 0..matrix.length # print matrix
    print matrix[i]
    puts
  end

end

########################################################
# Creates the hash from the parsed input data          #
# and uses the modified class to do a topological sort #
########################################################

def totalCheck(counter,row)

  torder = Array.new

   for i in 0..counter - 1
     torder[i] = i
   end

  for i in 0..row.length - 1
    if row[i][0] == "X"
      row[i].clear
    else
      for j in 0..row[i].length - 1
        row[i][j] =  row[i][j].to_i
      end
    end
  end

  hash = Hash[torder.zip row]
  puts "The total order is "
  print hash.tsort
  puts

end

main


