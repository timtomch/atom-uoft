<?php

/*
 * This file is part of the Access to Memory (AtoM) software.
 *
 * Access to Memory (AtoM) is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Access to Memory (AtoM) is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Access to Memory (AtoM).  If not, see <http://www.gnu.org/licenses/>.
 */

class arElasticSearchActor extends arElasticSearchModelBase
{
  protected static
    $conn;

  public function populate()
  {
    if (!isset(self::$conn))
    {
      self::$conn = Propel::getConnection();
    }

    $sql  = 'SELECT actor.id';
    $sql .= ' FROM '.QubitActor::TABLE_NAME.' actor';
    $sql .= ' JOIN '.QubitObject::TABLE_NAME.' object ON actor.id = object.id';
    $sql .= ' WHERE actor.id != ? AND object.class_name = ?';
    $sql .= ' ORDER BY actor.lft';

    $actors = QubitPdo::fetchAll($sql, array(QubitActor::ROOT_ID, 'QubitActor'));

    // Loop through results, and add to search index
    foreach ($actors as $item)
    {
      $node = new arElasticSearchActorPdo($item->id);
      QubitSearch::getInstance()->addDocument($node->serialize(), 'QubitActor');
    }

    return count($actors);
  }
}
